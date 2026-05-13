{ config, pkgs, ... }:

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
    btop
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
      ll   = "ls -ls";
      vim  = "nvim";
      ".." = "cd ..";
      ff   = "fastfetch";
      hms  = "home-manager switch --flake ~/.config/nix-config#tristan@macbook";
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
        symbol   = " ";
        disabled = false;
      };
    };
  };

  ###########
  # -ALACRITTY?- #
  ###########
  # terminal emulator, I have some configuration applied to make it more enjoyable

programs.alacritty = {
  enable = true;
  settings = {
    window = {
      opacity = 0.9;
      padding = { x = 10; y = 10; };
    };
    font = {
      normal = {
        family = "JetBrainsMono Nerd Font";
        style = "Regular";
      };
      size = 14.0;
    };
    colors.dracula = {
      primary = {
        background = "#282a36";
        foreground = "#f8f8f2";
      };
      normal = {
        black   = "#21222c";
        red     = "#ff5555";
        green   = "#50fa7b";
        yellow  = "#f1fa8c";
        blue    = "#bd93f9";
        magenta = "#ff79c6";
        cyan    = "#8be9fd";
        white   = "#f8f8f2";
      };
    };
    colors = "dracula";
  };
};

  #########
  # -BAT- #
  #########
  # bat is like `cat` but with syntax highlighting and line numbers.

  programs.bat = {
    enable = true;
    config = {
      theme       = "TwoDark";
      italic-text = "always";
      pager       = "less -FR";
    };
  };

  ##########
  #  -LF-  #
  ##########
  # This setting just lets the `lf` command see hidden files and directories

  programs.lf = {
    enable          = true;
    settings.hidden = true;
  };
}
