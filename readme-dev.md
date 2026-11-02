## Dev Tools

Cheat sheet for the tooling in `modules/languages.nix` (per-language toolchains) and `modules/dev-tools.nix` (cross-language tools) - not a tutorial for any of these, just enough to remember what each thing is for and how to actually run it.

### Rust

- `rustup` manages the toolchain. `rustup show` tells you what's installed. `cargo` is what you actually use day to day.
- `cargo new my-project` starts a plain project, `cargo generate` scaffolds from a template if I want something less bare.
- `cargo build` / `cargo run` / `cargo test` are the three I'll use constantly.
- `cargo clippy` - linter, catches more than the compiler alone will. Comes with `rustup`.
- `cargo fmt` - formatter, also comes with `rustup`.
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

### Nix

- `nixfmt file.nix` formats a file - this is what backs `nix fmt` if the flake declares a formatter.
- `statix check .` lints a directory for common antipatterns, `statix fix .` applies the safe fixes automatically.
- `deadnix .` lists unused bindings/imports, `deadnix -e .` edits them out in place.
- `nixd` is the LSP - the editor uses it, I don't call it directly. It evaluates against the actual flake so it knows real option types, not guesses.
- `nix flake check` evaluates every output in this flake without building - the fast way to catch a typo'd option or broken import.
- `nix repl .` drops into a repl with this flake's outputs loaded, handy for poking at `nixosConfigurations.tristan.config.something` without a full rebuild.

### Python

- `uv init` starts a project, `uv add some-package` / `uv remove some-package` manages dependencies - no separate `pip install` or `poetry add` step.
- `uv run script.py` runs inside the project's venv automatically, creating it on first use - no manual `source .venv/bin/activate`.
- `uv venv` creates a bare venv by hand if a project isn't using `uv`'s project mode.
- `uv python install 3.12` grabs a specific Python version if the project needs one newer/older than what's on the system.
- `ruff check .` lints, `ruff check --fix .` autofixes what it safely can.
- `ruff format .` formats - this replaces `black`.
- `pyright` is the LSP, same deal as the others - the editor uses it for types and autocomplete, I don't call it directly.

### Cross-language (`dev-tools.nix`)

- `just` is a command runner - drop a `justfile` in a project with `build`, `test`, `run` recipes so I don't have to remember if it's `cargo test`, `go test ./...`, or `uv run pytest` for this one. Same muscle memory either way.
- `claude-code` - `claude` in a project directory.

### direnv

This one's not tied to any one language, it's a shell thing. Normally if a project needs specific tools or env vars, I'd have to set that up by hand every time I `cd` into it. direnv watches for a `.envrc` file in a directory and auto-loads whatever's in it the moment I `cd` in, then unloads it when I leave. Paired with Nix (`nix-direnv`), it means a project with its own `flake.nix` can declare its own toolchain and I just `cd` in and it's there - no manually running `nix develop` every time.

To use it in a project:
1. Drop a `.envrc` file in the project root with `use flake` in it (if the project has a `flake.nix`), or `use nix` for an old-style `shell.nix`.
2. Run `direnv allow` once in that directory - it won't auto-load anything it hasn't been told it's okay to run.
3. From then on, `cd` into the project and the environment just shows up. `cd` out and it's gone.

I don't need this for anything in `nix-config` itself - it's for other projects that aren't part of this repo.
