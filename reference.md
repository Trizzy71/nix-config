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

## Channel policy
Quick note (note by `claude-code`) for keeping track of the channels.

Both inputs are pinned to the **26.05 release branch**, not `nixos-unstable`:

- `nixpkgs` → `nixos-26.05`
- `home-manager` → `release-26.05`

This is important because home-manager's options only sync up with `nixpkgs` within a release. So they’re versioned together on purpose. When you run `nix flake update`, expect backported fixes instead of months of changes. Don’t forget to commit `flake.lock` after every update!

Remember, `system.stateVersion` records the release a host was first installed with, should never be changed. This setting can be found in each `hosts/*/configuration.nix`.
