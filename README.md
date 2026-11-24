# Tetorica FM2610 Synth for Desktop

Play the Neo Geo YM2610 or the six-channel YM2610B from the keyboard and
JavaScript. Edit FM, SSG, ADPCM-A and ADPCM-B sounds, follow VGM playback and
keep sounds and scripts together in a Cassette. The app bundles the same
frontend, WASM synthesis core and Web Audio worklets as the web app.
[Tetorica FM2610 Synth](https://kyorohiro.github.io/hello_ymfm_wasm/synth-fm2610/)

## Run and build

Install Node.js 22, Python 3.11 or newer, Rust and the Tauri 2 platform build
tools. Run these commands from this checkout.

```sh
npm ci
npm test
cargo test --manifest-path src-tauri/Cargo.toml --locked
npm run dev
```

The bundled synth and plain Code editor work offline. Monaco loads its
editor and completion features from the same CDN as the web app when
available. Web Audio plays the WASM-rendered sound. Cassette, sound and WAV
exports open the operating system's save dialog.

For a local macOS build, run `npm run build -- --bundles app --no-sign -- --locked`.
The app bundle is created at
`src-tauri/target/release/bundle/macos/Tetorica FM2610 Synth.app`.

Build with `npm run build -- --bundles app,dmg` on macOS,
`npm run build -- --bundles nsis` on Windows, or
`npm run build -- --bundles deb,appimage` on Linux. The Build Desktop workflow
builds installers for Apple silicon and Intel macOS, x64 Windows, and x64
and ARM64 Linux. Run `sh deploy_mac.sh` to build both macOS installers with
your configured Apple signing identity and notarization credentials.

## Update the bundled web app

```sh
npm run import:release -- /path/to/tetorica-fm2610-synth-html.zip --version 0.1.2
npm run check:release
```

Import validates the ZIP, replaces `dist/`, and records the archive SHA-256
and every bundled file's SHA-256 in `release.lock.json`. `--version` updates
the desktop app version in its npm, Cargo and Tauri package metadata and
lockfiles. Commit `dist/` and `release.lock.json` together. Use
`npm run record:edits` to record deliberate local changes to bundled files.

The readable frontend is under `dist/synth-fm2610/`. Tauri attaches its save
dialog bridge at startup. The separate FM2610 source ZIP includes the C++
synthesis core, the native effects code and the WASM build recipes.
