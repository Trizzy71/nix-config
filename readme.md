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

### Hosts Overview

| Host | Type | Notes |
|---|---|---|
| `jensen` | NixOS | My gaming and work desktop, NVIDIA 4070 Ti Super, loving KDE Plasma 6 |
| `lisa` | NixOS | Taryn's gaming desktop, AMD RX 480, KDE Plasma 6, kept minimal |
| `qtile-node` | NixOS | Tailscale exit node, generic - one config for any number of machines |
| `macbook` | home-manager | Standalone on aarch64-darwin |

## Repo Structure

```
nix-config
├── flake.lock                           # exact version #s and hashes
├── flake.nix                            # table of contents - inputs, plus one line per machine
├── hosts                                # one folder per machine
│   ├── jensen                           # gaming + work desktop (NVIDIA), named for the nvidia ceo
│   │   ├── configuration.nix            # everything on the machine - imports, hostname, stateVersion
│   │   ├── hardware-configuration.nix   # generated on install - disks, kernel modules
│   │   └── home.nix                     # user environment - which modules/home files tristan gets
│   ├── lisa                             # taryn's gaming desktop (AMD), kept minimal, named for the amd ceo
│   │   ├── configuration.nix
│   │   ├── hardware-configuration.nix
│   │   └── home.nix
│   ├── macbook                          # standalone home-manager
│   │   └── home.nix
│   └── qtile-node                       # tailscale exit node - generic, installs on any x86_64 UEFI box
│       ├── configuration.nix
│       ├── hardware-generic.nix         # hand-written, finds disks by label instead of UUID
│       └── home.nix                     # shell, git, firefox
├── modules
│   ├── nixos                            # system-wide - imported by a host's configuration.nix
│   │   ├── base.nix                     # every NixOS host - boot, network, locale, nix, home-manager, `nrs`, fwupd
│   │   ├── plasma.nix                   # the desktop (plasma 6) - swap for another desktop and keep the rest
│   │   ├── display-manager.nix          # sddm login screen, wayland
│   │   ├── audio.nix                    # pipewire, rtkit
│   │   ├── bluetooth.nix                # bluetooth stack
│   │   ├── fonts.nix                    # font packages
│   │   ├── lan.nix                      # avahi, printing, kdeconnect, krfb port
│   │   ├── desktop-apps.nix             # KDE apps, libreoffice, obs, system-wide
│   │   ├── flatpak.nix                  # flatpak + flathub remote
│   │   ├── gaming.nix                   # steam, launchers, sober (host also imports flatpak.nix)
│   │   ├── power.nix                    # cpu governor, nvtop, s-tui, powertop, lm_sensors
│   │   ├── gpu-amd.nix                  # amd settings, vulkan
│   │   ├── gpu-nvidia.nix               # nvidia settings, open kernel, power management
│   │   ├── ssh.nix                      # openssh, key-only login
│   │   ├── tailscale.nix                # joins the tailnet
│   │   ├── tailscale-exit-node.nix      # advertises as an exit node (host also imports tailscale.nix)
│   │   ├── user-taryn.nix               # user account
│   │   └── user-tristan.nix             # user account + ssh key
│   └── home                             # per-user - imported by a host's home.nix, also works on the mac
│       ├── ai.nix                       # claude-code from unstable
│       ├── apps.nix                     # gui apps - firefox, obsidian, zed, spotify, discord, signal, telegram, mpv, clipboard
│       ├── dev.nix                      # rust/go/nix/python toolchains, just, direnv
│       ├── git.nix                      # my username/email, basic settings, gh
│       └── shell-env.nix                # my shell environment - zsh, starship, kitty, helix, cli tools every host uses
├── readme.md                            # you are here
├── readme-cli.md                        # cheat-sheet for CLI tools in modules/home/shell-env.nix
├── readme-dev.md                        # cheat-sheet for modules/home/dev.nix
└── reference.md                         # quick commands and notes
```

### How to read it

1. `flake.nix` - lists the machines. Each one points at a single file.
2. `hosts/<machine>/configuration.nix` - the whole machine at a glance: every module it uses, plus anything only that machine has.
3. `hosts/<machine>/home.nix` - same idea for the user: which `modules/home` files they get.
4. Any module - each one is a small, self-contained chunk you can copy into your own config.

`modules/nixos` files only work in a `configuration.nix`, `modules/home` files only work in a `home.nix`. Mixing them up is the classic "option does not exist" error.

Modules never import other modules. Each `configuration.nix` and `home.nix` lists everything that machine or user gets, so you can read one file and know the whole picture.

## Why did I build it this way?

I chose to use flakes and home-manager. Flakes provide a single foundation for each of my hosts and the flake.lock that pins my versions of nixpkgs and home-manager which helps manage all of my machines from a single repo. Home-manager as a NixOS module means that a single `nixos-rebuild switch` on my hosts applies to the system AND the user config in one go. Flaptak being included alongside nix gives you a way to install packages which follow their own update cycle and are not tied to this config. For the Mac specifically, I could have chose to use `nix-darwin` which has much better integration with MacOS allowing you to controll MacOS settings and homebrew casks declaratively. I chose not to do this, it is my only Apple machine. I control all shell and tui packages through nix and all of my GUI apps from .dmg and the app store.

## Setting Up a New Host

1. Start by booting the installer ISO that matches the release, then partition and mount it.
2. Clone the repo straight to where it'll live permanently — since `/mnt` becomes `/` after reboot, cloning to `/mnt/home/<user>/repos/nix-config` lands it at `~/repos/nix-config` with no extra move later: `mkdir -p /mnt/home/<user>/repos && git clone <repo-url> /mnt/home/<user>/repos/nix-config`.
3. Run `nixos-generate-config --root /mnt --no-filesystems --show-hardware-config > /mnt/home/<user>/repos/nix-config/hosts/<host>/hardware-configuration.nix`.
4. Use `blkid` to fill in any placeholder UUIDs (ex. `/mnt/games` (an alternate partition for game storage) on `jensen`)
5. Run `nixos-install --root /mnt --flake /mnt/home/<user>/repos/nix-config#<host>`.
6. Reboot and set your password with `passwd`!
7. The repo was cloned as root during install, so fix ownership before it bites you later: `sudo chown -R <user>:users ~/repos/nix-config`.

## Adding an Exit Node

`qtile-node` doesn't use a generated hardware file, so the same config installs on as many machines as I want.

1. Boot the installer. Partition with a GPT table: a ~1G EFI partition and the rest for root. **The labels matter** - that's how the config finds the disks:
   `mkfs.fat -F 32 -n boot /dev/<efi>` and `mkfs.ext4 -L nixos /dev/<root>`
2. `mount /dev/disk/by-label/nixos /mnt && mkdir -p /mnt/boot && mount /dev/disk/by-label/boot /mnt/boot`
3. Clone the repo as in step 2 above, then `nixos-install --root /mnt --flake /mnt/home/tristan/repos/nix-config#qtile-node`. Skip `nixos-generate-config`.
4. Reboot, `passwd`, then `sudo tailscale up` and approve the exit node in the tailscale admin console.

Every node gets the hostname `qtile-node`; tailscale de-dupes them as `qtile-node-1`, `-2`, etc. Rename one with `sudo tailscale set --hostname <name>`.

**Converting an existing install** (with UUIDs, not labels): label the partitions first or it won't boot - `sudo e2label /dev/<root> nixos`, then `nix shell nixpkgs#dosfstools` and `sudo $(which fatlabel) /dev/<efi> boot`, then `nrs`. The previous generation is still in the boot menu if anything goes wrong.

## See something I should fix? Module missing? Message me on LinkedIn or open an issue, I'm always learning.
