# GBA CMake Template C

This is a project template for when you want to get started writing a GBA game in C.

The template comes with CMake presets automatically setting up a debug and release build.
It will automatically detect your [devkitARM](https://devkitpro.org/wiki/devkitARM) installation
and set up your compiler toolchain.

The [main.c](./main.c) contains a little demo using [tonclib](https://www.coranac.com/man/tonclib/main.htm) (aka libtonc),
but it is also very easy to switch to [libgba](https://github.com/devkitPro/libgba).
Using no support library and doing everything from scratch is also possible. Just remove the dependency.

## Requirements

 * CMake version 3.25 or newer
 * A devkitARM installation

## Known issues

The versions of `libgba` and `tonclib` which come with devkitARM are fairly old.
Specifically for `tonclib`, it makes sense to use the more recent [community fork](https://github.com/gbadev-org/libtonc).

As another alternative I want to mention [libseven](https://github.com/sdk-seven/libseven),
which aims to "replace existing libraries like libgba or libtonc".
