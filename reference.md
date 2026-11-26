## Reference
- Want to test a package without installing? Use: `nix run nixpkgs#package-name`
- Rebuild aliases:
  - NixOS hosts: `nrs` - defined once in `modules/nixos/base.nix`. No `#host` needed, `nixos-rebuild` picks the flake host matching the machine's hostname
  - macbook: `hms` (`home-manager switch ...`), in `hosts/macbook/home.nix`
- `nix fmt` formats every .nix file in the repo

## Rebuild commands
NixOS host:

```
sudo nixos-rebuild switch --flake ~/repos/nix-config#jensen
```

- `switch` can be swapped for `boot` if there are huge changes.

Standalone home-manager host (`macbook`):

```
home-manager switch --flake ~/repos/nix-config#macbook
```

## Setting up a new machine
Just clone it to where it lives and switch, no extra steps:

```
git clone <repo-url> ~/repos/nix-config
sudo nixos-rebuild switch --flake ~/repos/nix-config#<host>   # or: home-manager switch --flake ~/repos/nix-config#macbook
```

For a brand new install from scratch (partitioning, hardware-configuration.nix, etc.), see "Setting Up a New Host" in `readme.md`.

## Channel policy
Quick note (note by `claude-code`) for keeping track of the channels.

`nixpkgs` and `home-manager` are pinned to the **26.05 release branch**:

- `nixpkgs` → `nixos-26.05`
- `home-manager` → `release-26.05`

This is important because home-manager's options only sync up with `nixpkgs` within a release. So they're versioned together on purpose. When you run `nix flake update`, expect backported fixes instead of months of changes. Don't forget to commit `flake.lock` after every update!

`nixpkgs-unstable` is the exception, for the few packages that need to move faster (claude-code). It's imported right where it's used - see the `let unstable = ...` at the top of `modules/home/ai.nix`. Copy that pattern if something else needs unstable.

To pull a newer claude-code: `nix flake update nixpkgs-unstable`, rebuild, then commit `flake.lock`. Which model it uses is set by claude-code and your account, not nix.

Remember, `system.stateVersion` records the release a host was first installed with, should never be changed. This setting can be found in each `hosts/*/configuration.nix` (and `home.stateVersion` in each `home.nix`).
