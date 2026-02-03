# When a pnpm Upgrade Breaks Sharp: Debugging a Sneaky GLib Collision

A recent upgrade from `pnpm@10.10.0` to `pnpm@10.17.1` looked innocent enough. The change landed in CI alongside routine dependency bumps, and everything passed locally. Once the branch hit GitHub Actions, though, our end-to-end job (`pnpm app:server`) started crashing with:

```
/usr/local/bin/node: symbol lookup error: /usr/local/lib/x86_64-linux-gnu/libvips.so.42: undefined symbol: g_once_init_enter_pointer
```

Because the error only reproduced with the newer pnpm, we spent the first day treating the package manager as the primary suspect. What follows is the step-by-step trail from that red herring to the real culprit: a prebuilt copy of node-canvas quietly shipping an outdated GLib.

## The Symptom

The failing command (`pnpm app:server`) is just a wrapper around our Node dev server. It runs fine locally but dies instantly on CI runners as soon as the sharp addon initialises libvips. Even `node -e "require('sharp')"` throws the same undefined-symbol error on the runner.

## Step 1: Blaming pnpm

We rolled pnpm back to 10.10.0 and the problem vanished, so we assumed a regression in pnpm’s shell emulator. Newer pnpm versions are stricter about environment sanitisation, so the working theory was that `LD_LIBRARY_PATH` or `PKG_CONFIG_PATH` was being cleared somewhere along the way.

That hypothesis generated a lot of heat but no light: dumping `env`, comparing lockfiles, and poking at pnpm’s release notes produced nothing conclusive.

## Step 2: Inspect the Shared Libraries

Time to step away from pnpm and look directly at the native stack.

```bash
ldd /usr/local/lib/x86_64-linux-gnu/libvips.so.42
```

This confirmed that libvips was linked against the expected GLib (`/lib/x86_64-linux-gnu/libglib-2.0.so.0`) and other system libraries we install on the AMI. The same check on the sharp addon:

```bash
ldd $(node -p "require.resolve('sharp/build/Release/sharp-linux-x64.node')")
```

showed the identical dependency chain. So far, everything pointed to the correct copy of GLib.

## Step 3: Confirm the Build-Time GLib Version

If the symbol were genuinely missing, `pkg-config` would show an older version. Instead we saw:

```bash
pkg-config --modversion glib-2.0
# 2.80.0
```

and `nm` proved the symbol exists:

```bash
nm -D /lib/x86_64-linux-gnu/libglib-2.0.so.0 | grep g_once_init_enter_pointer
```

No mismatch there. The symbol is present in the system library, yet the loader still reports it undefined.

## Step 4: Ask the Loader What It Is Doing

Enter the most useful trick of the investigation:

```bash
LD_DEBUG=libs,symbols node -e "require('sharp')"
```

This is a glibc feature, not a Node switch. It tells the dynamic linker to trace every library it loads and every symbol it resolves. Grepping the output immediately surfaced the surprise:

```
symbol=g_once_init_enter_pointer; lookup in file=/usr/local/lib/x86_64-linux-gnu/libvips.so.42
symbol=g_once_init_enter_pointer; lookup in file=/home/runner/_work/drplt/drplt/node_modules/.pnpm/canvas@3.1.0/node_modules/canvas/build/Release/libglib-2.0.so.0
```

So libvips really was finding a different GLib—but not the one under `/lib`. The canvas package had tucked a private `libglib-2.0.so.0` next to its compiled addon, and the loader grabbed that copy first. It happened to be built against GLib 2.68, which predates the `g_once_init_enter_pointer` helper.

## Step 5: Why This Suddenly Started Happening

The answer was sitting in the `pnpm-lock.yaml` diff. In the same PR we bumped `prebuild-install` (to pick up a security fix in `tar-fs`). Earlier installs attempted to fetch a canvas prebuild and failed, so they fell back to compiling canvas from source on the runner. Once the new `prebuild-install` landed, the download started to succeed. The tarball contains a full dependency bundle including GLib, GObject, and friends.

Because `canvas.node` is linked with `RUNPATH=$ORIGIN`, the loader resolves its dependencies relative to its own directory. Those libraries are loaded with the default `RTLD_GLOBAL` scope, so when sharp later asks for `libglib-2.0.so.0`, the linker reuses the earlier handle instead of going back to `/lib`.

No pnpm bug—just a new binary blob quietly entering the process.

## Fixing the Collision

We landed on two practical fixes:

1. **Force canvas to build from source** so it links against the system GLib that we maintain alongside libvips. In CI the one-liner is:

   ```bash
   npm_config_build_from_source=canvas pnpm install --frozen-lockfile
   ```

   The same env var works locally when developers reinstall.

2. **(Optional stopgap)** export the good library before launching Node:

   ```bash
   export LD_PRELOAD=/lib/x86_64-linux-gnu/libglib-2.0.so.0
   pnpm app:server
   ```

   This forces the loader to prioritise the system GLib, but it is only a temporary workaround.

With either fix in place, the undefined symbol error disappears even under pnpm 10.17.1.

## Takeaways

- When native code blows up after an innocuous change, instrument the loader with `LD_DEBUG` before blaming the nearest JavaScript tool.
- Prebuilt binaries often bundle more than just the primary addon. If you rely on system libraries (libvips + custom libheif in our case), ensure you are still compiling the addons that need to interoperate with them.
- Writing down the debugging trail is worth the time. The next engineer to hit a symbol error can start with `LD_DEBUG=libs,symbols` and save hours of guesswork.

This episode looked like a pnpm regression and turned out to be a crossfire between node-canvas and libvips. The dynamic linker logs told the real story.
