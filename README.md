# sph

`sph` is a Nim library for dealing with cryptographic hashes. It is a fairly
thin wrapper of [sphlib][sphlib]. 

The library can be installed through [Nimble][nimble]: `nimble install sph`.

The API is as follows:

```nim
import sph

var context = SphInit[SHA256]()
SphUpdate(context, "hello ")
SphUpdate(context, "world")
let digest1 = SphFinalize(context)

# convenience wrapper
let digest2 = SphHash[SHA256]("hello world")
check(digest1 == digest2) # assertion passes

```

The list of available hash functions is:

* `SHA0`
* `SHA1`
* `SHA224`
* `SHA256`
* `SHA384`
* `SHA512`
* `Tiger`
* `Tiger2`
* `MD2`
* `MD4`
* `MD5`
* `RIPEMD`
* `RIPEMD128`
* `RIPEMD160`
* `Whirlpool`
* `Whirlpool0`
* `Whirlpool1`
* `Panama`
* `RadioGatun32`
* `RadioGatun64`
* `HAVAL128_3`
* `HAVAL128_4`
* `HAVAL128_5`
* `HAVAL160_3`
* `HAVAL160_4`
* `HAVAL160_5`
* `HAVAL192_3`
* `HAVAL192_4`
* `HAVAL192_5`
* `HAVAL224_3`
* `HAVAL224_4`
* `HAVAL224_5`
* `HAVAL256_3`
* `HAVAL256_4`
* `HAVAL256_5`

[sphlib]: http://www.saphir2.com/sphlib/
[nimble]: https://github.com/nim-lang/nimble
