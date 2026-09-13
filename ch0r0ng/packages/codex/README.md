# Codex CLI for the local channel

Package: `codex@0.154.0`, module `(ch0r0ng packages codex)`.

```sh
guix build -L "$HOME/cchanl" codex@0.154.0 --cores=4 --max-jobs=4
guix shell -L "$HOME/cchanl" codex@0.154.0 -- codex --version
```

The system configuration already registers this channel's local module path.
To install system-wide, add `"codex@0.154.0"` to its package specifications and
run the usual system reconfigure. This package does not modify account settings
or create Codex credentials.

## Sources and build

* Codex release: `rust-v0.154.0`, commit
  `6b9826e3aa83b1a5947db50f4332cb9c65f1b340`.
* Rust compiler: Guix `rust-1.95`, matching the upstream toolchain.
* Rust dependencies: generated from upstream `codex-rs/Cargo.lock` with
  `guix import crate`, including 1,317 registry sources and six pinned Git trees.
* V8: OpenAI's official sandbox-enabled `150.4.0` static archive and matching
  Rust bindings from the `rusty-v8-v150.4.0` release. SHA-256 hashes are pinned in
  `codex.scm`. The release checksum manifests were verified against
  `third_party/v8/rusty_v8_150_4_0_release_manifests.sha256` in the Codex commit.
  **V8 is precompiled; this is not an entirely source-built package.**

Cargo runs offline in the Guix build environment. The CLI, Linux sandbox
launcher, Code Mode host, and voice host are compiled from Rust sources.
Codex's vendored bubblewrap C sources are built as a separate small derivation
and installed as `codex-resources/bwrap`. A final assembly derivation combines
the results; adjustments to resource installation reuse the Rust build.
Release LTO is disabled and codegen units are set to 16 to limit memory usage.
System `protoc` is used instead of executing the vendored prebuilt protoc.

`prepare.py` maps the locked Git dependencies to local source paths while
preserving each repository's workspace inheritance. These trees are placed
outside `codex-rs` so Cargo does not infer membership in the Codex workspace.
It also adds `/gnu/store` alongside upstream's `/nix/store` handling and adds
store paths for fallback shells.

The installed package has `bin/codex`, `codex-package.json`, and
`codex-resources/`. The latter includes Code Mode, ripgrep, and a private voice
directory with the required GStreamer plugins. Voice library files are copied
rather than symlinked because upstream verifies their physical paths.

## Regenerating dependencies

Run this after checking out the desired upstream release:

```sh
guix import crate --lockfile=/path/to/codex/codex-rs/Cargo.lock codex \
  > /tmp/codex-crates.raw.scm
python3 ch0r0ng/packages/codex/generate-crates.py \
  /tmp/codex-crates.raw.scm ch0r0ng/packages/codex/crates.scm
```

Update the source version/commit/hash, compiler version, V8 artifact version
and hashes, generated header, package metadata, and verification expectations
when upgrading. Recheck Git dependency adaptation against upstream manifests.

## Verification

The package's check phase exercises CLI subcommands and helper entrypoints
without network access or credentials. Additional installed-package checks:

```sh
out=$(guix build -L "$HOME/cchanl" codex@0.154.0 --cores=4 --max-jobs=4)
python3 ch0r0ng/packages/codex/verify.py "$out"
```

`verify.py` runs a Guix store shell in the Linux sandbox and verifies forbidden
writes are blocked. It executes `6 * 7` in the actual Code Mode V8 runtime, performs the
voice build-commit handshake, initializes the private GStreamer runtime and
plugins, and shuts down the helper. It does not access microphones, speakers,
accounts, or model endpoints. This is packaging validation, not the complete
upstream test suite. The recipe provides x86_64 and aarch64 Linux artifact
hashes; only x86_64 Linux is exercised in this WSL environment.

Validated on 2026-09-13 with Guix commit
`e2a58c8d4c09467a0386b0f94aa9c8f6d8298dd9`: build and offline runtime checks.
All 1,481 resolved lockfile package/version entries match upstream, with
registry checksums unchanged. Guix lint passed for synopsis, description,
native-input placement, and derivation.
