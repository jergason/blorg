# Shared Library Debugging Cheatsheet

## Inspect linked libraries
- **Command**: `ldd /path/to/binary`
- **Use**: See which shared objects a binary depends on and the exact paths the loader will use.
- **Example**: `ldd /usr/local/lib/x86_64-linux-gnu/libvips.so.42`

## Trace the dynamic loader
- **Command**: `LD_DEBUG=libs,symbols <executable>`
- **Use**: Ask glibc’s loader to print where it searches for `.so` files and how symbols are resolved.
- **Example**: `LD_DEBUG=libs,symbols node -e "require('sharp')"`
- **Tip**: Add `| grep <library>` or set `LD_DEBUG_OUTPUT=/tmp/ld.log` to limit output.

## Confirm build-time versions
- **Command**: `pkg-config --modversion <module>`
- **Use**: Report which version headers point to; useful for spotting build/runtime mismatches.
- **Example**: `pkg-config --modversion glib-2.0`

## Inspect loader cache
- **Command**: `ldconfig -p | grep <library>`
- **Use**: List every shared library the loader knows about and the paths it scans.
- **Example**: `ldconfig -p | grep libglib-2.0`

## Check exported symbols
- **Command**: `nm -D /path/to/lib.so | grep <symbol>`
- **Use**: Verify that a shared object exports the symbol you expect.
- **Example**: `nm -D /lib/x86_64-linux-gnu/libglib-2.0.so.0 | grep g_once_init_enter_pointer`

## Locate competing copies
- **Command**: `find / -name '<lib>.so*' 2>/dev/null`
- **Use**: Discover stray vendored builds of a library.
- **Example**: `find /home/runner/_work -name 'libglib-2.0.so*' 2>/dev/null`

## Inspect RUNPATH/RPATH
- **Command**: `readelf -d <binary> | grep -i runpath`
- **Use**: Reveal embedded search paths that prioritise bundled libraries.
- **Example**: `readelf -d node_modules/.pnpm/canvas@3.1.0/node_modules/canvas/build/Release/canvas.node | grep -i runpath`
