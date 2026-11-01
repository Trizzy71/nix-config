{ pkgs, ... }:

# -DEV TOOLS-
# learning rust and go
{
  home.packages = with pkgs; [
    # -RUST-
    rustup # manages rust toolchains - gives you cargo, rustc, clippy, rustfmt
    # rust-analyzer # lsp for rust - needed for the editor to be useful
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

    # -BOTH-
    just # one command runner instead of remembering cargo vs go incantations
  ];

  # -DIRENV-
  # auto-loads a project's env when you cd in, unloads when you cd out
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true; # caches nix shells so they don't rebuild every time
  };
}
