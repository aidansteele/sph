
import strutils
import macros

proc aryToString*(x: openarray[cuchar]): string =
  result = newStringOfCap(len(x))
  for i in x:
    add(result, i)

macro defineSphHash*(typ: untyped, length: int, name: string = "", initAlias = "", updateAlias = "", closeAlias = "", typDef: stmt): expr {.immediate.} =
  result = newStmtList()
  add(result, typDef)
  
  let ini = if len($initAlias) == 0: "sph_" & $name & "_init" else: $initAlias
  let upd = if len($updateAlias) == 0: "sph_" & $name else: $updateAlias
  let clo = if len($closeAlias) == 0: "sph_" & $name & "_close" else: $closeAlias
  
  let codeStr = """
proc sph_$1_init(ctx: ptr $2): void {.importc: "$3".}
proc sph_$1(ctx: ptr $2, data: cstring, dataLen: uint64): void {.importc: "$4".}
proc sph_$1_close(ctx: ptr $2, dst: pointer): void {.importc: "$5".}
  """ % [$name, $typ, ini, upd, clo]
  
  let code = parseStmt(codeStr)
  add(result, code)
  
  let procs = """
proc sphInit*(ctx: var $2): void =
  sph_$1_init(addr(ctx))

proc sphUpdate*(ctx: var $2, data: string): void =
  sph_$1(addr(ctx), cstring(data), uint64(len(data)))
  
proc sphFinalize*(ctx: var $2): string =
  var buf: array[$3, cuchar] 
  sph_$1_close(addr(ctx), addr(buf))
  result = aryToString(buf)
""" % [$name, $typ, $length.intVal]
  add(result, parseStmt(procs))
