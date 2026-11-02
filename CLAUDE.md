Think before writing. Simplicity first. Surgical changes. Always in my voice.

NixOS hosts:
hosts/tristan/home.nix
hosts/taryn/home.nix
hosts/qtile-node/home.nix
hosts/macbook/home.nix # would like to modify with nix-darwin as well as nix-homebrew

nix modules:
ai.nix               # whisper nvidia ollama speech-to-text-script
base-system.nix      # core settings systemd zsh nix
communication.nix    # discord, telegram, signal, localsend
daily-tools.nix      # useful terminal utilities
desktop-apps.nix     # obsidian zed spotify
desktop-plasma.nix   # plasma, pipewire, bluetooth, fonts
desktop-suite.nix    # desktop applications, libreoffice, utilities
dev-tools.nix        # rust/go packages
exit-node.nix        # ssh and tailscale
flatpak.nix          # enables flatpaks if you are too lazy to edit config files
gaming.nix           # launchers, power/thermal diag, gamemode/gamescop
git.nix              # my username/email, basic settings
gpu-amd.nix          # amd settings, vulkan
gpu-nvidia.nix       # nvidia settings, open kernel, power management
shell.nix            # kitty, aliases, config, more tools
ssh-system.nix       # ssh - public key
tailscale-system.nix # tailscale
user-taryn.nix       # user account
user-tristan.nix  

readme*.me files are for my personal knowledge, not yours.
