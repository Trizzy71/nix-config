{ config, pkgs, ... }:

{
  home.username = "tristan";
  home.homeDirectory = "/Users/tristan";
  home.stateVersion = "25.11";

  ################
  #  -PACKAGES-  #
  ################
  # These are "unmanaged" packages, no setup.
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

  # ---------------------------------------------------------------------------
  # SESSION VARIABLES
  # These are environment variables set every time you open a shell.
  # EDITOR tells programs (like git) which editor to open by default.
  #
  # GROWTH AREA: You can add things like:
  #   LANG = "en_US.UTF-8";
  #   PATH = "$HOME/.local/bin:$PATH";  # add custom script folders to PATH
  # ---------------------------------------------------------------------------
  home.sessionVariables = {
    EDITOR = "nvim";   # when git asks you to write a commit message, nvim opens
  };

  # ----------------------------//==========\\------------------------------- #
  # ---------------------------||  PROGRAMS  ||------------------------------ #
  # ----------------------------\\==========//------------------------------- #

  # ZSH
  # home-manager can fully manage your zsh config. Enabling this means
  # home-manager writes your ~/.zshrc for you from the options below.
  #
  # GROWTH AREA: You can add a lot more here:
  #   oh-my-zsh or starship prompt (a beautiful, fast prompt)
  #   plugins = [ "git" "z" "syntax-highlighting" ];
  #   initExtra = '' ... ''; for any raw zsh code you want appended
  # ---------------------------------------------------------------------------
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

  programs.kitty = {
    enable = true;
    theme = "Tokyo Night";
    settings = {
      # Background Stuff
      dynamic_background_opacity = true;
      background_opacity    = "0.7";
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

  # ---------------------------------------------------------------------------
  # NEOVIM
  # home-manager has deep support for neovim. `enable = true` installs it
  # and everything else here writes your init.lua config file automatically.
  #
  # `viAlias` and `vimAlias` mean you can type `vi` or `vim` and neovim opens.
  # (This works alongside the shellAlias above — belt and suspenders.)
  #
  # GROWTH AREA: This is where neovim configs can grow a lot:
  #   plugins = [ pkgs.vimPlugins.lazy-nvim ... ]; to add plugins
  #   popular first plugins: nvim-treesitter (better syntax),
  #   telescope.nvim (fuzzy file finding), nvim-lspconfig (IDE features)
  # ---------------------------------------------------------------------------
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

  # BAT
  # bat is like `cat` but with syntax highlighting and line numbers.
  # home-manager manages its config here.
  #
  # GROWTH AREA: bat has many themes. Run `bat --list-themes` in your terminal
  # to preview them all. Some popular ones: Dracula, gruvbox-dark, Nord.
  # ---------------------------------------------------------------------------
  programs.bat = {
    enable = true;
    config = {
      theme  = "TwoDark";   # a pleasant dark theme
      italic-text = "always";
      pager  = "less -FR";  # how bat pages long files; -F auto-quits if short
    };
  };

  # ---------------------------------------------------------------------------
  # GIT
  # Even basic git config is worth managing here so it travels with you.
  #
  # GROWTH AREA: you can add:
  #   signing.key and signing.signByDefault for GPG commit signing
  #   aliases = { lg = "log --oneline --graph"; };
  #   delta (a beautiful git diff viewer) via programs.git.delta.enable
  # ---------------------------------------------------------------------------
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

  # ---------------------[[BROKEN]]--------------------------------------------
  # Tailscale
  # don't know anything about how to take care of this yet
  #----------------------------------------------------------------------------
  # programs.tailscale = {
  #   enable = true;
  # };
  #### I want the above  to work but i think it needs to be environment.systemPackages with []
  # services.tailscale.enable = true;
  # environment.systemPackages = [
  #   pkgs.tailscale
  # ];


  # ---------------------------------------------------------------------------
  # home-manager manages itself. Always keep this.
  # ---------------------------------------------------------------------------
  programs.home-manager.enable = true;
}
