{ pkgs, ... }:

# -DEV-
# toolchains + lsp/lint/fmt per language, plus cross-language tools
{
  home.packages = with pkgs; [
    # -CROSS-LANGUAGE-
    just # command runner

    # -RUST-
    rustup # manages rust toolchains - gives you cargo, rustc, clippy, rustfmt
    cargo-watch # rebuilds and reruns on file changes
    cargo-edit # cargo add/rm/upgrade from the command line
    cargo-expand # shows the code after macro expansion
    cargo-nextest # nicer test runner than cargo test
    cargo-generate # scaffolds a new project from a template

    # -GO-
    go # the go toolchain - compiler, gofmt, go vet, go test, all in one
    gopls # the official go lsp
    delve # go debugger
    golangci-lint # bundles a bunch of go linters into one
    gotools # goimports and friends

    # -NIX-
    nixd # lsp for nix - evaluates against this flake's actual inputs
    nixfmt # the official nix formatter (RFC 166 style)
    statix # linter - catches common nix antipatterns
    deadnix # finds unused bindings/imports in nix files

    # -PYTHON-
    python3
    uv # fast all-in-one package/venv manager - replaces pip, virtualenv, poetry
    ruff # fast rust-based linter + formatter - replaces flake8, black, isort
    pyright # lsp - type checking and autocomplete

    # -C-
    gcc
  ];

  # -DIRENV-
  # auto-loads a project's env when you cd in, unloads when you cd out
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true; # caches nix shells so they don't rebuild every time
  };
}
