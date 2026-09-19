# Guide - Modules/Flake

## Overview
Welcome to my `nix-config` repo! This space is all about my journey into modularization and version control, learning as I go.

### Goals
I'd like to keep things:
- [x] Version Controlled
- [x] Modular
- [ ] Secrets (For API keys and Tailscale access. I will probably use `sops-nix` or `agenix`)

## What's Inside
This repo contains:
- NixOS system configs and modules
- `home-manager` configurations
- Personal notes

### Hosts Overview

| Host | Type | Notes |
|---|---|---|
| `tristan` | NixOS | My gaming and work desktop, NVIDIA 4070 Ti Super, loving KDE Plasma 6 |
| `taryn` | NixOS | Another gaming desktop, AMD RX 480, KDE Plasma 6 |
| `dell` | NixOS | Tailscale exit node, qtile. Needs `--impure` (see below) |
| `frank-test` | NixOS | Exit-node test box |
| `2-test` | NixOS | Another exit-node test box |
| `macbook` | home-manager | Standalone on aarch64-darwin |
| `arch` | deprecated | x86_64-linux (out with the old!) |

## Channel policy
Quick note (note by `claude-code`) for keeping track of the channels.

Both inputs are pinned to the **26.05 release branch**, not `nixos-unstable`:

- `nixpkgs` → `nixos-26.05`
- `home-manager` → `release-26.05`

This is important because home-manager's options only sync up with `nixpkgs` within a release. So they’re versioned together on purpose. When you run `nix flake update`, expect backported fixes instead of months of changes. Don’t forget to commit `flake.lock` after every update!

Remember, `system.stateVersion` marks the release a host was first installed with. It should always stay consistent. This setting can be found in each `hosts/*/configuration.nix`.

.
├── flake.lock
├── flake.nix
├── hosts
│   ├── 2-test
│   │   ├── configuration.nix
│   │   ├── hardware-configuration.nix
│   │   └── home.nix
│   ├── arch
│   │   └── home.nix
│   ├── dell
│   │   ├── configuration.nix
│   │   └── home.nix
│   ├── frank-test
│   │   ├── configuration.nix
│   │   ├── hardware-configuration.nix
│   │   └── home.nix
│   ├── macbook
│   │   └── home.nix
│   ├── taryn
│   │   ├── configuration.nix
│   │   ├── hardware-configuration.nix
│   │   └── home.nix
│   └── tristan
│       ├── configuration.nix
│       ├── hardware-configuration.nix
│       └── home.nix
├── modules
│   ├── base-system.nix
│   ├── daily-tools.nix
│   ├── desktop-apps.nix
│   ├── desktop-plasma.nix
│   ├── desktop-suite.nix
│   ├── dev-tools.nix
│   ├── exit-node.nix
│   ├── flatpak.nix
│   ├── gaming.nix
│   ├── git.nix
│   ├── gpu-amd.nix
│   ├── gpu-nvidia.nix
│   ├── neovim.nix
│   ├── shell.nix
│   ├── ssh-system.nix
│   ├── tailscale-system.nix
│   ├── testing.nix
│   ├── user-taryn.nix
│   └── user-tristan.nix
└── readme.md

10 directories, 38 files

## Workstation hosts - Desktop stack (`tristan`, `taryn`)
Both machines are getting the full OS kit: `desktop-plasma.nix` (Plasma 6, SDDM, PipeWire, Bluetooth, printing), `desktop-suite.nix` (all the apps you need), and `flatpak.nix` (for my users who don't know Nix (all of them)).

## Reference
- Want to test a package without installing? Use: `nix run nixpkgs#package-name`
- Every host has a rebuild alias in its `home.nix`:
  - NixOS hosts: `nrs` (`nixos-rebuild switch ...`)
  - standalone home-manager hosts: `hms` (`home-manager switch ...`)

## Rebuild commands
NixOS host:

```
sudo nixos-rebuild switch --flake ~/.config/nix-config#tristan
```

- `switch` can be swapped for `boot` if there are huge changes.

### Important note for `dell`
This host was designed before I figured out how to manage hardware-configuration.nix. It needs `--impure`, as its `flake.nix` pulls its `hardware-configuration.nix` from `/etc/nixos/hardware-configuration.nix` directly on the machine. Unfortunately, this means `dell` can’t be evaluated from anywhere else.

Standalone home-manager hosts (`macbook`, `arch`):

```
home-manager switch --flake ~/.config/nix-config#macbook
```



## Setting Up a New Host
1. Start by booting the installer ISO that matches the release, then partition and mount it.
2. Run `nixos-generate-config --root /mnt --no-filesystems --show-hardware-config` -> Copy this into `hosts/<host>/hardware-configuration.nix`.
3. Use `blkid` to fill in any placeholder UUIDs (ex. `/mnt/games` (an alternate partition for game storage) on `tristan`)
4. Run `nixos-install --flake /mnt/etc/nixos/nix-config#<host>`.
5. Reboot and set your password with `passwd`!

See something I should fix? Module missing? Message me on LinkedIn or open an issue, I'm always learning.
