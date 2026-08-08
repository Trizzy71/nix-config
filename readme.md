# Guide - Modules/Flake

## Overview
This repo, `nix-config` is dedicated to my learning of modularization and version control.

My specific goals are:
- [x] Version Controlled
- [x] Modular
- [ ] Secrets usage

## Summary
This repo contains the following components:
- NixOS system configs and modules
- home-manager configurations

### Hosts

| Host | Kind | Notes |
|---|---|---|
| `tristan` | NixOS | Gaming/workstation desktop, NVIDIA 4070 Ti Super, KDE Plasma 6 |
| `taryn` | NixOS | Gaming desktop, AMD RX 480, KDE Plasma 6 |
| `dell` | NixOS | Tailscale exit node, qtile. Needs `--impure` (see below) |
| `frank-test` | NixOS | Exit-node test box |
| `2-test` | NixOS | Exit-node test box |
| `macbook` | standalone home-manager | aarch64-darwin |
| `arch` | deprecated | x86_64-linux |

## Channel policy
This section was written for me by claude-code for quick reference in the future.

Both inputs are pinned to the **26.05 release branch**, not `nixos-unstable`:

- `nixpkgs` → `nixos-26.05`
- `home-manager` → `release-26.05`

home-manager's module options are only guaranteed to match nixpkgs within a
release, so the two are versioned together on purpose. `nix flake update` pulls
backported fixes rather than six months of churn. Commit `flake.lock` after
every update.

`system.stateVersion` records the release a host was *first installed* with and
must never be bumped. It lives in each `hosts/*/configuration.nix`, not in the
shared `modules/base-system.nix`.

## Workstation hosts - Modern stack (`tristan`, `taryn`)
Both get `desktop-plasma.nix` (Plasma 6, SDDM, PipeWire, Bluetooth, printing),
`desktop-suite.nix` (the app suite) and `flatpak.nix`.

### Flatpak
Enabled on both desktop hosts as a fallback.

```
flatpak update
```
## Reference
- Testing a package without installing: `nix run nixpkgs#package-name`
- Every host defines a rebuild alias in its `home.nix`:
  - NixOS hosts: `nrs`
  - standalone home-manager hosts: `hms`

## Rebuild commands
NixOS hosts (home-manager runs as a NixOS module, so the whole system rebuilds
as one unit — `home-manager switch` does not apply):

```
sudo nixos-rebuild switch --flake ~/.config/nix-config#tristan
```

- `switch` can be swapped for `boot` if there are huge changes.
# I need to fix the following but it still applies
- `dell` additionally needs `--impure`, because `flake.nix` pulls its
  `hardware-configuration.nix` from `/etc/nixos/hardware-configuration.nix` on
  the machine itself rather than from this repo. As a side effect, `dell` is the
  one host that cannot be evaluated from anywhere else.

Standalone home-manager hosts (`macbook`, `arch`):

```
home-manager switch --flake ~/.config/nix-config#macbook
```

## Installing a new host
1. Boot the matching release installer ISO, partition and mount.
2. `nixos-generate-config --root /mnt --no-filesystems --show-hardware-config`
   → paste into `hosts/<host>/hardware-configuration.nix`.
3. `blkid` → fill in any placeholder UUIDs (e.g. `/mnt/games` on `tristan`).
4. `nixos-install --flake /mnt/etc/nixos/nix-config#<host>`.
5. Reboot and change the password with `passwd`.
