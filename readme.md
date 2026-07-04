# Guide - Modules/Flake

## Overview
This repo, `nix-config` is dedicated to my learning of modularization and version control
My specific goals are:
- [x] Version Controlled
- [ ] Modular
- [ ] Secrets usage
- [x] Tailscale demo for Al

## Summary
This repo contains the following components:
- Configuration files for different machine (`macbook`, `arch`, `dell`).
- NixOS system configs and modules
- home-manager configurations

## Reference
You can always reach for google but the most-used commands are here:
    - Rebuild: `home-manager switch --flake ~/path/to/nix-config#____` # The blank will be for `arch , dell , macbook , work-test`
    - Testing packages: `nix run nixpkgs#package-name

## NixOS specific:
- Rebuild command:
  - `nixos-rebuild switch --flake ~/nix-config#dell --impure`
  - The `switch` can be swapped for `boot` if there are huge changes
  - `--impure` allows the build to include files not inside `nix-config`, this is required because flake.nix pulls the `hardware-configuration.nix` file on the dell from the dell itself at `/etc/nixos/hardware-configuration.nix`
    - This is required because hardware-configuration is generated locally on the machine when you install NixOS. We don't want it version controlled.
