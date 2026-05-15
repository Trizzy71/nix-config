{ pkgs, ... }:

##########################
#  -UNMANAGED PACKAGES-  #
##########################
# For configuration, use "programs" below for nix managed configs

{
  home.packages = with pkgs; [
    nano
    wget
    lf
    fzf
#     btop
    tldr
    fastfetch
    asciiquarium
  ];

  #######################
  # -SESSION VARIABLES- #
  #######################
  # Environment variables are set every time you open a shell
  # Growth: you can add `LANG = "en_US.UTF-8";`

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  #########
  # -ZSH- #
  #########
  # This is the shell, I enabled syntax highlighting here to make things more readable
  # I also added some shell aliases to make it easier to write common commands

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -ls";
      vim = "nvim";
      ".." = "cd ..";
      ff = "fastfetch";
      hms = "home-manager switch --flake ~/.config/nix-config#tristan@macbook";
    };
  };

  ##############
  # -STARSHIP- #
  ##############
  # shell prompt, shows git status

  programs.starship = {
    enable = true;
    settings = {
      git_branch = {
        symbol = " ";
        disabled = false;
      };
    };
  };

  ###########
  # -KITTY- #
  ###########
  # terminal emulator, I have some configuration applied to make it more enjoyable

  programs.kitty = {
    enable = true;
    themeFile = "Dracula";
    settings = {
      dynamic_background_opacity = true;
      background_opacity = "0.9";
      background_blur = 5;
      font_size = 14;
      font_family = "JetBrainsMono Nerd Font";
      cursor_blink_interval = "0.5";
      cursor_shape = "beam";
      scrollback_lines = 10000;
      enable_audio_bell = false;
      enabled_layouts = "tall,stack";
      tab_bar_style = "powerline";
    };
  };

  #########
  # -BAT- #
  #########
  # bat is like `cat` but with syntax highlighting and line numbers.

  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      italic-text = "always";
      pager = "less -FR";
    };
  };

  ##########
  #  -LF-  #
  ##########
  # This setting just lets the `lf` command see hidden files and directories

  programs.lf = {
    enable = true;
    settings.hidden = true;
  };
}
