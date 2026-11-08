## CLI Tools

Cheat sheet for everything in `modules/shell.nix` - what each thing is and the commands I'll actually forget.

### Navigation

- `eza` - better `ls`. `ll` is aliased to `eza -la --git` for a long listing with git status, `eza --tree` for a tree view.
- `zoxide` - learns directories I visit. After `cd`-ing into a place a few times, `z partial-name` jumps straight there from anywhere. `zi` does the same but with an fzf picker if I can't remember the exact name.
- `lf` - terminal file manager. Launch with `lf`, move with arrows or `hjkl`, `d`/`y`/`p` cut/copy/paste, `q` to quit. Hidden files are shown by default (set in the config).
- `fzf` - fuzzy finder. Not wired into shell keybinds, so I use it directly: pipe a list into it (`history | fzf`) or wrap another command (`vim $(fzf)`, `cd $(find . -type d | fzf)`).

### Editors

- `helix` (`hx`) - the editor. `hx file` to open, `i` for insert mode, `Esc` back to normal, `:w` save, `:q` quit, `:wq` both, space is the leader key for the built-in menu. `vim` is aliased to `hx`.

### Multiplexers

- `tmux` - `tmux` to start a session, `Ctrl+b c` new window, `Ctrl+b %`/`"` split panes, `Ctrl+b d` detach, `tmux attach` to get back in.
- `zellij` - `zellij` to start, keybinds show on screen so I don't need to memorize them, `Ctrl+p` pane mode, `Ctrl+t` tab mode, `Ctrl+o d` detach.

### System info / monitoring

- `fastfetch` (`ff`) - system info banner.
- `btop` - resource monitor. Launch with `btop`, `q` to quit.
- `tldr` - simplified man pages. `tldr tar`, `tldr nmap`, etc instead of wading through a full man page.

### Network

- `nmap` - `nmap -sn 192.168.1.0/24` for a quick scan of what's on the LAN, `nmap localhost` to check open ports on this machine.

### Files / text

- `bat` - `cat` with syntax highlighting and line numbers. `bat file`, `bat --list-themes` to browse themes.

### Terminal (kitty)

- New tab: `Ctrl+Shift+t`. New split: `Ctrl+Shift+Enter`. Cycle layout (tall/stack): `Ctrl+Shift+l`.
- Background opacity/blur, font, and theme are all set in `shell.nix` already - nothing to configure here.

### Prompt (starship)

- Just runs - shows directory and git branch. Nothing to invoke by hand.

### Misc

- `claude-code` - `claude` in a project directory.
- `asciiquarium` - for fun. `asciiquarium`, `Ctrl+c` to stop watching fish swim across the terminal.

### Proxmox
```sh
pct list                      # all LXCs: ID, status, name
pct status <ID>               # running / stopped
pct enter <ID>                # shell inside the LXC
pct exec <ID> -- docker ps    # run one command without entering
pct config <ID>               # check features (nesting/keyctl), mounts, net
pct start <ID> / pct stop <ID> / pct reboot <ID>
```

### Docker (LXC)
```sh
docker ps                          # running containers + ports
docker ps -a                       # include stopped/crashed ones
docker logs -f --tail 100 <name>   # follow a container's logs
docker stats                       # live CPU/RAM per container
docker inspect <name>              # full config (mounts, networks, env)
docker restart <name>
docker compose ps                  # (in the compose project folder)
docker compose logs -f             # logs for the whole stack
docker compose pull && docker compose up -d   # update a stack
docker system df                   # what's using disk (images, volumes)
docker volume ls                   # list volumes
```
