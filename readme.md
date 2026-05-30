# Guide - Modules/Flake

## Summary
This repo (nix-config) is dedicated to my learning of modularization and version control
My specific goals are:
- [x] Version Controlled
- [ ] Modular
- [ ] Secrets usage
- [ ] Tailscale demo for Al

## Reference
You can always reach for google but the most-used commands are here:
    - Rebuild: `home-manager switch --flake ~/path/to/nix-config#____` # The blank will be for `arch , dell , macbook , work-test`
    - Testing packages: `nix run nixpkgs#package-name

