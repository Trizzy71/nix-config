Here is the structure and a coule rules. Check here before blink file reads. Think before writing. Simplicity first. Surgical changes. Always in my voice. Be as critical as you can about structure and content while working with the flake.

flake.nix            # inputs + one line per host, nothing else
hosts/<host>/configuration.nix  # everything on a NixOS machine - module imports, hostname, host-only bits
hosts/<host>/home.nix           # which modules/home files the user gets
hosts/jensen         # nvidia desktop
hosts/lisa           # amd desktop kept minimal - no dev toolchains, no git.nix
hosts/qtile-node     # exit node, generic - hardware-generic.nix finds disks by label, no generated hardware file
hosts/macbook/home.nix # standalone home-manager. would like to modify with nix-darwin as well as nix-homebrew to declaratively manage all packages on machine

modules/nixos (system, only in configuration.nix):
base.nix             # every NixOS host - boot, network, locale, nix, home-manager wiring, nrs alias
desktop.nix          # plasma, pipewire, bluetooth, fonts
desktop-suite.nix    # KDE apps, libreoffice, obs
flatpak.nix          # flatpak + flathub remote
gaming.nix           # steam, launchers, power/thermal diag, sober (imports flatpak.nix)
gpu-amd.nix          # amd settings, vulkan
gpu-nvidia.nix       # nvidia settings, open kernel, power management
ssh.nix              # ssh - public key
tailscale-exit-node.nix # tailscale + advertise exit node
user-taryn.nix       # user account
user-tristan.nix     # user account

modules/home (home-manager, only in home.nix, shared with mac):
ai.nix               # parked, not imported - whisper ollama speech-to-text-script (CUDA)
apps.nix             # obsidian zed spotify + discord telegram signal localsend
daily-tools.nix      # linux-only terminal utilities
dev.nix              # rust/go/nix/python toolchains, claude-code (unstable), just, direnv
git.nix              # my username/email, basic settings
shell.nix            # zsh, kitty, helix, aliases, cli tools - every host

readme*.me files are for my personal knowledge, not yours. Please keep them up to date after changes.
