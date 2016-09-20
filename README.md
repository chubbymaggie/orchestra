# Orchestra

Orchestra is a small helper project designed to coordinate the various projects
involved in `rev.ng`.

With Orchestra you can:

* Clone all the necessary repositories:
  * `revamb`: the main project.
  * `qemu`: the modified version of QEMU allowing us to obtain tinycode for any
    of the supported architectures
  * `llvm`: the LLVM compiler framework we support, it's almost the vanilla one,
    except for some minor bugfixes.
  * `clang`: the vanilla LLVM C/C++ compiler, we need it to compile certain
    parts of QEMU into LLVM IR that we can later link to the translated program.
  * `compiler-rt`: the compiler runtime, with minor patches to improve the
    support for x86 software floating point operations.
* Build and configure all the above mentioned components correctly, plus
  building the three toolchains we currently support
  (`armv7a-hardfloat-linux-uclibceabi`, `mips-unknown-linux-musl` and
  `x86_64-gentoo-linux-musl`).
* Install all the components into a single directory.
* Build and configure `revamb` so that you're all set to start hacking the code.

By default the code is built into the `build/` directory and installed into the
`root/` directory.

Orchestra is known to work on Ubuntu 14.04 and 16.04.

## How to build

```
sudo apt-get install libboost-dev gawk libmpc-dev libmpfr-dev libgmp-dev \
                     texinfo pkg-config zlib1g-dev libglib2.0-dev wget git \
                     cmake build-essential python
./bootstrap.sh --clean
cd build/revamb
ctest
```
