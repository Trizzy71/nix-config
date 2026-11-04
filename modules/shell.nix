{ pkgs, ... }:

{
  # -UNMANAGED PACKAGES-
  # nano and wget come from the system profile (modules/base-system.nix).
  home.packages = with pkgs; [
    asciiquarium
    lf # tui file manager
    fzf # fuzzy finding
    btop # tui resource monitor
    tldr # simplified man pages
    fastfetch # fast system information
    nmap
    eza # ls replacement
    tmux
    zellij
  ];

  # -SESSION VARIABLES-
  # env variables set at shell start
  home.sessionVariables = {
    EDITOR = "hx"; # default text editor (sub for nano if need)
    LANG = "en_US.UTF-8"; # language settings (optional)
  };

  # -ZSH-
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true; # suggest commands while typing
    syntaxHighlighting.enable = true; # syntax highlighting
    shellAliases = {
      # aliases for *every* host
      vim = "hx"; # vim to hx
      ".." = "cd .."; # parent directory
      ff = "fastfetch"; # sys info
      ll = "eza -la --git"; # stands for long list, lists hidden files as well
    };
  };

  # -STARSHIP PROMPT-
  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$character";
      directory = {
        style = "bold blue";
        repo_root_style = "bold purple";
        repo_root_format = "[$before_root_path]($style)[$repo_root]($repo_root_style)[$path]($style) ";
        truncation_length = 100;
        truncate_to_repo = false;
      };
      git_branch = {
        symbol = "";
        format = "[$symbol$branch]($style) ";
        style = "bold green";
      };
      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[>](bold red)";
      };
    };
  };

  # -KITTY TERMINAL-
  programs.kitty = {
    enable = true;
    # kitten themes writes to themes.conf, not managed by nix
    extraConfig = ''
      include themes.conf
      include light-theme.auto.conf
      include dark-theme.auto.conf
    '';
    settings = {
      font_size = 14;
      font_family = "JetBrainsMono Nerd Font"; # font family
      cursor_blink_interval = "0.5"; # cursor blink
      cursor_shape = "beam"; # cursor shape
      cursor_trail = 3; # cursor trail shows after moving more than 3 cells
      cursor_trail_decay = "0.1 0.4"; # how quickly the trail fades
      scrollback_lines = 10000; # scrollback buffer
      enable_audio_bell = false; # disable audio
      enabled_layouts = "tall,stack"; # layout configs
      tab_bar_style = "separator"; # flat tabs separated by a line, no powerline arrows
      tab_separator = " ┇"; # character between tabs
      active_tab_font_style = "bold"; # make the active tab stand out without arrows
    };
  };

  # -HELIX CONFIGURATION-
  # named ANSI colors, palette comes from kitty
   xdg.configFile."helix/themes/kitty-ansi.toml".text = ''
     "comment" = { fg = "gray", modifiers = ["italic"] }
     "keyword" = "magenta"
     "string" = "green"
     "function" = "blue"
     "type" = "yellow"
     "constant" = "cyan"
     "constant.numeric" = "cyan"
     "variable.builtin" = "red"
     "operator" = "cyan"
     "ui.selection" = { bg = "blue" }
   '';

  programs.helix = {
    enable = true;
    settings.theme = "kitty-ansi";
  };

  # -BAT CONFIGURATION-
  programs.bat = {
    enable = true;
    config = {
      theme = "ansi"; # follows terminal palette
      italic-text = "always"; # always use italic text
      pager = "less -FR"; # paging command
    };
  };

  # -LF FILE BROWSER-
  programs.lf = {
    enable = true;
    settings.hidden = true; # show hidden files
  };

  # -ZOXIDE-
  programs.zoxide.enable = true; # jump to frecent dirs with z
}
