# Guide - Modules/Flake

## Overview
This repo, `nix-config` is dedicated to my learning of modularization and version control.

My specific goals are:
- [x] Version Controlled
- [ ] Modular
- [ ] Secrets usage
- [x] Tailscale demo for Al

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
| `arch` | standalone home-manager | x86_64-linux |

## Channel policy
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

## Desktop hosts (`tristan`, `taryn`)
Both get `desktop-plasma.nix` (Plasma 6, SDDM, PipeWire, Bluetooth, printing),
`desktop-suite.nix` (the app suite) and `flatpak.nix`.

`services.desktopManager.plasma6.enable` already provides Dolphin, Konsole,
Kate, **Okular** (PDF), Gwenview, Ark, Spectacle, Discover, Elisa, KInfoCenter,
KWalletManager and plasma-systemmonitor — do not re-declare these in
`desktop-suite.nix`. Notably `kcalc` is *not* among them.

### Flatpak
Enabled on both desktop hosts as an escape hatch, with the Flathub remote
registered by a systemd oneshot. Nix remains the primary source of software;
Flatpak is a second, separate update path:

```
flatpak update
```

Flatpak apps appear in the Plasma launcher automatically — the NixOS module
adds the exports directories to `environment.profiles`, and sets
`fonts.fontDir.enable` so they can see host fonts.

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
