# Prebuilt Rust for this channel

`rust-bin@1.98.1`, module `(ch0r0ng packages rust)`, installs Rust's official
2026-09-03 stable binaries. This is deliberately a **binary package**, not a
replacement for Guix's source-built `rust` or a rustup installation.

```sh
guix build -L . rust-bin
guix shell -L . --pure rust-bin -- rustc --version
guix shell -L . --pure rust-bin -- cargo --version
```

The `out` output contains rustc, rustdoc, the host standard library, Cargo,
rustfmt, and Clippy. The `cargo` output exposes the same Cargo executable via
a symlink, to support Guix's existing `cargo-build-system` interface. This
keeps upstream's sysroot and companion-tool discovery intact. Full HTML Rust
documentation, rust-src, rust-analyzer, and cross-target standard libraries
are not included.

To use it as a build dependency:

```scheme
(use-modules (ch0r0ng packages rust))

;; Within a package using cargo-build-system:
(arguments (list #:rust rust-bin ...))
```

## Guix adaptation

The package pins dated component URLs and SHA256 hashes from the official
[release manifest](https://static.rust-lang.org/dist/channel-rust-1.98.1.toml).
It does not fetch manifests during evaluation or run rustup. Runtime compiler
and standard-library files remain together, with ELF interpreters and RUNPATHs
patched to store paths. RUNPATH validation is enabled.

Wrappers supply the Guix C toolchain and libc startup-file search path. On
x86-64, compiler drivers default to `-C linker-features=-lld` so native linking
uses Guix's linker wrapper rather than bypassing it through bundled LLD.
Explicit compiler arguments can override this default. The bundled LLVM is
kept because it is part of the upstream compiler's matching binary toolchain.

This package targets native `x86_64-linux` and `aarch64-linux` development;
it does not claim to supply a cross-compilation sysroot. Installing it does
not change any other package's compiler selection.

## Verification and updates

The build runs installed compiler/tool version checks, direct rustc compilation
and execution, Cargo tests (including doctests and a build script), Cargo run,
rustfmt, Clippy, and rustdoc, all without registry access. To additionally
exercise Guix's standard Cargo build system:

```sh
guix build -L . -f tests/rust-bin.scm
```

For 1.98.1, the package and integration fixture have been built and tested on
`x86_64-linux`, including Cargo tests with an empty environment and only the
toolchain on `PATH`. The `aarch64-linux` derivation has been evaluated, but
has not been built or run on an ARM machine.

When updating, check `channel-rust-stable.toml`, then obtain the versioned
manifest and update `%rust-version`, `%rust-date`, and both architectures'
component hashes in `rust.scm`. Manifest keys `clippy-preview` and
`rustfmt-preview` correspond to archives named `clippy` and `rustfmt`.
Re-run the package build and the Cargo integration fixture. A successful
derivation evaluation for another architecture is not a runtime test.
