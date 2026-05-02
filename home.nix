{ config, pkgs, ... }:

{
  home.username = "tristan";
  home.homeDirectory = "/Users/tristan";
  home.stateVersion = "25.11";

  ##########################
  #  -UNMANAGED PACKAGES-  #
  ##########################
  # For configuration, use "programs" below for nix managed configs
  
  home.packages = with pkgs; [
    nano       # simple terminal text editor
    wget       # download files from the terminal, e.g: wget https://example.com/file.zip
    lf         # keyboard driven file browser
    fzf        # fuzzy finder
    btop       # resource monitor
    asciiquarium
    cmatrix
    tldr       # too long didn't read
    fastfetch  # quick id
    # Personal Projects
    zig        # zig, dude
    zls        # zig language server
  ];

  #######################
  # -SESSION VARIABLES- #
  #######################
  # Environment variables are set every time you open a shell
  # Growth: you can add `LANG = "en_US.UTF-8";`

  home.sessionVariables = {
    EDITOR = "nvim";   # when git asks you to write a commit message, nvim opens
  };

  # ----------------------------//==========\\------------------------------- #
  # ---------------------------||  PROGRAMS  ||------------------------------ #
  # ----------------------------\\==========//------------------------------- #

  #########
  # -ZSH- #
  #########
  # This is the shell, I enabled syntax highlighting here to make things more readable
  # I also added some shell aliases to make it easier to write common commands

  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
    };
    syntaxHighlighting.enable = true;
    # Shortcuts!
    shellAliases = {
      ll   = "ls -ls";
      vim  = "nvim";
      cat  = "bat";
      ".." = "cd ..";
      hms  = "home-manager switch --flake ~/.config/home-manager";
      ff   = "fastfetch";
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

  ###########
  # -KITTY- #
  ###########
  # terminal emulator, I have some configuration applied to make it more enjoyable

  programs.kitty = {
    enable = true;
    theme = "Tokyo Night";
    settings = {
      # Background Stuff
      dynamic_background_opacity = true;
      background_opacity    = "0.8";
      background_blur       = 10;
      # Fonts
      font_size             = 14;
      font_family           = "JetBrainsMono";
      # Feel
      cursor_blink_interval = "0.5";
      cursor_shape          = "beam";
      scrollback_lines      = 10000;
      enable_audio_bell     = false;
      # Layout
      enabled_layouts       = "tall,stack";
      # Colors
      tab_bar_style         = "powerline";
    };
  };

  ############
  # -NEOVIM- #
  ############
  # terminal text editor, can be a bit faster than nano but they keybinds are rough

  programs.neovim = {
    enable      = true;
    withRuby    = false;
    withPython3 = false;

    # extraConfig is written in Vimscript (the classic vim language).
    # For a beginner config this is fine. Later you can switch to
    # extraLuaConfig = '' ... ''; for modern Lua-based neovim config.
    extraConfig = ''
      " --- Display ---
      set number          " show line numbers on the left
      set relativenumber  " show distance to other lines (useful for jumping)
      set cursorline      " highlight the line your cursor is on
      set wrap            " wrap long lines visually (doesn't change the file)
      set scrolloff=5     " keep 5 lines visible above/below cursor when scrolling

      " --- Indentation ---
      set tabstop=2       " a tab character appears as 2 spaces wide
      set shiftwidth=2    " when you press >>, indent by 2 spaces
      set expandtab       " pressing tab inserts spaces, not a tab character
      set smartindent     " auto-indent new lines intelligently

      " --- Search ---
      set ignorecase      " searching is case-insensitive by default...
      set smartcase       " ...unless you type a capital letter
      set hlsearch        " highlight all search matches
      set incsearch       " show matches as you type

      " --- Clipboard ---
      " This makes neovim use the macOS system clipboard.
      " yy to copy a line, p to paste — works across apps.
      set clipboard=unnamedplus

      " --- Colorscheme ---
      " 'habamax' is a clean dark theme included with neovim, no plugins needed.

      " --- Quality of Life ---
      set mouse=a         " enable mouse support (click to move cursor, scroll)
      set undofile        " remember undo history even after closing a file
      set splitright      " when you split a window, open new one on the right
      set splitbelow      " when you split horizontally, open new one below
    '';
  };

  ##########
  #  -LF-  #
  ##########
  # This setting just lets the `lf` command see hidden files and directories

  programs.lf = {
    enable = true;
    settings = {
      hidden = true;
    };
  };

  #########
  # -BAT- #
  #########
  # bat is like `cat` but with syntax highlighting and line numbers.

  programs.bat = {
    enable = true;
    config = {
      theme  = "TwoDark";   # a pleasant dark theme
      italic-text = "always";
      pager  = "less -FR";  # how bat pages long files; -F auto-quits if short
    };
  };

  #########
  # -GIT- #
  #########
  # git config, this is for managing the dotfiles

  programs.git = {
    enable    = true;
    settings = {
      user = {
        Name  = "tristan";
        Email = "tristan.m.peterson@gmail.com";   # replace with your real email
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = false;   # plain merge on git pull
      };
    };
  };

  # ---------------------------------------------------------------------------
  # home-manager manages itself. Always keep this.
  # ---------------------------------------------------------------------------
  programs.home-manager.enable = true;
}
