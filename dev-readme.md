## Dev Tools

Learning rust and go. This is my cheat sheet for the tooling in `modules/dev-tools.nix`, not a rust or go tutorial - just enough to remember what each thing is for and how to actually run it.

### Rust

- `rustup` manages the toolchain. `rustup show` tells you what's installed. `cargo` is what you actually use day to day.
- `cargo new my-project` starts a plain project, `cargo generate` scaffolds from a template if I want something less bare.
- `cargo build` / `cargo run` / `cargo test` are the three I'll use constantly.
- `cargo nextest run` instead of `cargo test` once a project has more than a couple tests - faster, nicer output.
- `cargo watch -x run` reruns on every save, good for not alt-tabbing back to the terminal every time.
- `cargo add some-crate` / `cargo rm some-crate` instead of hand-editing `Cargo.toml`.
- `cargo expand` shows what a macro actually expands into, useful when something's confusing.
- `rust-analyzer` isn't something I run by hand - it's the LSP, the editor talks to it for autocomplete, go-to-def, inline errors.

### Go

- `go run .` / `go build` / `go test ./...` cover most of it.
- `go fmt ./...` formats, `go vet ./...` catches obvious mistakes before they become bugs.
- `golangci-lint run` bundles a pile of linters into one command, worth running before I think something's "done."
- `goimports` (from `gotools`) cleans up import blocks - `gofmt` alone won't do this part.
- `dlv debug` if I actually need to step through code instead of guessing with print statements.
- `gopls` is the LSP, same deal as rust-analyzer - the editor uses it, I don't call it directly.

### Both

- `just` is a command runner - drop a `justfile` in a project with `build`, `test`, `run` recipes so I don't have to remember if it's `cargo test` or `go test ./...` for this one. Same muscle memory either way.

### direnv

This one's not a rust or go tool, it's a shell thing. Normally if a project needs specific tools or env vars, I'd have to set that up by hand every time I `cd` into it. direnv watches for a `.envrc` file in a directory and auto-loads whatever's in it the moment I `cd` in, then unloads it when I leave. Paired with Nix (`nix-direnv`), it means a project with its own `flake.nix` can declare its own toolchain and I just `cd` in and it's there - no manually running `nix develop` every time.

To use it in a project:
1. Drop a `.envrc` file in the project root with `use flake` in it (if the project has a `flake.nix`), or `use nix` for an old-style `shell.nix`.
2. Run `direnv allow` once in that directory - it won't auto-load anything it hasn't been told it's okay to run.
3. From then on, `cd` into the project and the environment just shows up. `cd` out and it's gone.

I don't need this for anything in `nix-config` itself - it's for other projects that aren't part of this repo.
