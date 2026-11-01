## Reference
- Want to test a package without installing? Use: `nix run nixpkgs#package-name`
- Every host has a rebuild alias in its `home.nix`:
  - NixOS hosts: `nrs` (`nixos-rebuild switch ...`)
  - standalone home-manager hosts: `hms` (`home-manager switch ...`)

## Where this flake actually lives
The repo's real home is `~/repos/nix-config`. `~/.config/nix-config` — the path baked into every `nrs`/`hms` alias and the commands below — is a symlink to it, managed declaratively by `modules/repo-symlinks.nix` (imported on every host). You don't manage that symlink by hand; home-manager activation creates/repairs it on every switch.

## Rebuild commands
NixOS host:

```
sudo nixos-rebuild switch --flake ~/.config/nix-config#tristan
```

- `switch` can be swapped for `boot` if there are huge changes.

Standalone home-manager hosts (`macbook`, `arch`):

```
home-manager switch --flake ~/.config/nix-config#macbook
```

## Setting up a new machine
`~/.config/nix-config` doesn't exist yet on a fresh machine, so the very first rebuild has to point at the real path directly:

```
git clone <repo-url> ~/repos/nix-config
sudo nixos-rebuild switch --flake ~/repos/nix-config#<host>   # or: home-manager switch --flake ~/repos/nix-config#macbook
```

After that first switch, home-manager activation creates the `~/.config/nix-config` symlink, and `nrs`/`hms` work unchanged from then on.

## Channel policy
Quick note (note by `claude-code`) for keeping track of the channels.

Both inputs are pinned to the **26.05 release branch**, not `nixos-unstable`:

- `nixpkgs` → `nixos-26.05`
- `home-manager` → `release-26.05`

This is important because home-manager's options only sync up with `nixpkgs` within a release. So they’re versioned together on purpose. When you run `nix flake update`, expect backported fixes instead of months of changes. Don’t forget to commit `flake.lock` after every update!

Remember, `system.stateVersion` records the release a host was first installed with, should never be changed. This setting can be found in each `hosts/*/configuration.nix`.
