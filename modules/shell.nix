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
    helix
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
    # no themeFile, colors come from light/dark files below
    extraConfig = ''
      include light-theme.auto.conf
      include dark-theme.auto.conf
    '';
    settings = {
      dynamic_background_opacity = true; # opacity settings enable
      background_opacity = "0.9";
      background_blur = 5;
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

  # -KITTY COLORS-
  # Breeze (light) and Breeze Dark palettes. kitty loads whichever file matches
  # the system color scheme.
  xdg.configFile."kitty/light-theme.auto.conf".text = ''
    background #eff0f1
    foreground #232627
    cursor #232627
    cursor_text_color #eff0f1
    selection_background #3daee9
    selection_foreground #fcfcfc
    active_tab_background #eff0f1
    active_tab_foreground #232627
    inactive_tab_background #d6d8da
    inactive_tab_foreground #4d4d4d
    tab_bar_background #d6d8da
    color0 #232627
    color1 #ed1515
    color2 #11d116
    color3 #f67400
    color4 #1d99f3
    color5 #9b59b6
    color6 #1abc9c
    color7 #bdc3c7
    color8 #7f8c8d
    color9 #c0392b
    color10 #1cdc9a
    color11 #fdbc4b
    color12 #3daee9
    color13 #8e44ad
    color14 #16a085
    color15 #fcfcfc
  '';

  xdg.configFile."kitty/dark-theme.auto.conf".text = ''
    background #232627
    foreground #fcfcfc
    cursor #fcfcfc
    cursor_text_color #232627
    selection_background #3daee9
    selection_foreground #fcfcfc
    active_tab_background #31363b
    active_tab_foreground #fcfcfc
    inactive_tab_background #1b1e20
    inactive_tab_foreground #a1a9b1
    tab_bar_background #1b1e20
    color0 #232627
    color1 #ed1515
    color2 #11d116
    color3 #f67400
    color4 #1d99f3
    color5 #9b59b6
    color6 #1abc9c
    color7 #fcfcfc
    color8 #7f8c8d
    color9 #c0392b
    color10 #1cdc9a
    color11 #fdbc4b
    color12 #3daee9
    color13 #8e44ad
    color14 #16a085
    color15 #ffffff
  '';

  # -BAT CONFIGURATION-
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark"; # theme
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
