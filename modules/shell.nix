{ pkgs, ... }:

{
  # -UNMANAGED PACKAGES-
  # use "programs" below for nix-managed configs
  home.packages = with pkgs; [
    asciiquarium
    nano # text editor
    wget # file downloads
    lf # tui file manager
    fzf # fuzzy finding
    btop # tui resource monitor
    tldr # simplified man pages
    fastfetch # fast system information
    nmap
    # claude-code this will come soon
  ];

  # -SESSION VARIABLES-
  # env variables set at shell start
  home.sessionVariables = {
    EDITOR = "nvim"; # default text editor (sub for nano if need)
    LANG = "en_US.UTF-8"; # language settings (optional)
  };

  # -ZSH-
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true; # suggest commands while typing
    syntaxHighlighting.enable = true; # syntax highlighting
    shellAliases = {
      vim = "nvim"; # vim to nvim
      ".." = "cd .."; # parent directory
      ff = "fastfetch"; # sys info
      hms = "home-manager switch --flake ~/.config/nix-config#macbook"; # home manager switch
      ll = "ls -a"; # stands for long list, lists hidden files as well
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
    themeFile = "Dracula"; # theme for terminal
    settings = {
      dynamic_background_opacity = true; # opacity settings enable
      background_opacity = "0.9"; # background opacity
      background_blur = 5; # background blur
      font_size = 14; # font size
      font_family = "JetBrainsMono Nerd Font"; # font family
      cursor_blink_interval = "0.5"; # cursor blink
      cursor_shape = "beam"; # cursor shape
      scrollback_lines = 10000; # scrollback buffer
      enable_audio_bell = false; # disable audio
      enabled_layouts = "tall,stack"; # layout configs
      tab_bar_style = "powerline"; # style for tabs bar
    };
  };

  # -BAT CONFIGURATION-
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark"; # theme
      italic-text = "always"; # always use italic text
      pager = "less -FR"; # paging command
    };
  };

  #  -LF FILE BROWSER-
  programs.lf = {
    enable = true;
    settings.hidden = true; # show hidden
  };
}
