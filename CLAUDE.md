Here is the structure and a couple rules. Check here before blind file reads. Think before writing. Simplicity first. Surgical changes. Code comments are always in my voice - anything else, I don't care about. Be as critical as you can about structure and content while working with the flake.

Rules:
- modules never import other modules. the host's configuration.nix or home.nix lists every module it uses.
- every package lives in one module, named for what it's for. don't list it twice.
- claude-code comes from nixpkgs-unstable (ai.nix). other fast-moving packages get the same treatment.
- the desktop is swappable: plasma.nix is the desktop, display-manager.nix and the rest stay when it changes.

flake.nix            # inputs + one line per host, nothing else
hosts/<host>/configuration.nix  # every module a NixOS machine uses, hostname, host-only bits
hosts/<host>/home.nix           # every modules/home file the user gets
hosts/jensen         # nvidia desktop
hosts/lisa           # amd desktop kept minimal - no dev toolchains, no ai, no git.nix
hosts/qtile-node     # exit node, generic - hardware-generic.nix finds disks by label, no generated hardware file
hosts/macbook/home.nix # standalone home-manager. would like to modify with nix-darwin as well as nix-homebrew to declaratively manage all packages on machine

modules/nixos (system, only in configuration.nix):
base.nix             # every NixOS host - boot, network, locale, nix, home-manager wiring, nrs alias, lspci/lsusb, fwupd
plasma.nix           # the desktop - plasma 6. swap for another desktop and keep the rest
display-manager.nix  # sddm login screen, wayland. stays when the desktop changes
audio.nix            # pipewire, rtkit
bluetooth.nix        # bluetooth stack
fonts.nix            # font packages
lan.nix              # things on the local network - avahi, printing, kdeconnect, krfb port
desktop-apps.nix     # gui apps system-wide - kde apps, libreoffice, obs
flatpak.nix          # flatpak + flathub remote - escape hatch, on jensen + lisa
gaming.nix           # steam, launchers, gamemode, sober (needs flatpak.nix on the host)
power.nix            # cpu governor, nvtop, s-tui, powertop, lm_sensors
gpu-amd.nix          # amd settings, vulkan
gpu-nvidia.nix       # nvidia settings, open kernel, power management
ssh.nix              # sshd, key-only login
tailscale.nix        # joins the tailnet
tailscale-exit-node.nix # advertises this machine as an exit node. needs tailscale.nix on the same host
user-taryn.nix       # user account
user-tristan.nix     # user account + ssh key

modules/home (home-manager, only in home.nix, shared with mac):
ai.nix               # claude-code from unstable
apps.nix             # gui apps - firefox, obsidian, zed, spotify, discord, signal, telegram, localsend, mpv, clipboard tools
dev.nix              # rust/go/nix/python toolchains, just, direnv
git.nix              # my username/email, basic settings, gh
shell-env.nix        # my shell environment - zsh, starship, kitty, helix, and the cli tools every host uses, mac included

readme*.md files are for my personal knowledge, not yours. Please keep them up to date after changes.
