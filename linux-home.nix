{ config, pkgs, ... }:

{
  home.username = "tristan";
  home.homeDirectory = "/home/tristan";
  home.stateVersion = "25.11";

  # ---------------------------------------------------------------------------
  # PACKAGES
  # These are "unmanaged" packages — Nix installs them but doesn't configure
  # them. Great for simple CLI tools that don't need any setup.
  #
  # GROWTH AREA: As your config grows, you might move some of these into
  # dedicated `programs.<name>` blocks below (like we did for neovim and bat)
  # which gives you Nix-managed config files for each tool.
  # ---------------------------------------------------------------------------
  home.packages = with pkgs; [
    nano       # simple terminal text editor, good fallback
    wget       # download files from the terminal, e.g: wget https://example.com/file.zip
    lf         # terminal file manager, navigate folders with keyboard
    fzf        # fuzzy finder — powers ctrl+r history search and more
    btop       # beautiful resource monitor (cpu, ram, etc)
    asciiquarium
    cmatrix
    tldr
    fastfetch
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

  # ---------------------------------------------------------------------------
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

    # Handy shortcuts. Type the alias instead of the full command.
    # e.g. typing `ll` runs `ls -la`
    shellAliases = {
      ll   = "ls -la";          # long list with hidden files
      vim  = "nvim";            # typing vim opens neovim instead
      cat  = "bat";             # typing cat uses bat (prettier output)
      ".." = "cd ..";           # go up one folder
      hms  = "home-manager switch --flake ~/.config/home-manager"; # apply your config
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
    viAlias     = true;   # typing `vi` opens neovim
    vimAlias    = true;   # typing `vim` opens neovim
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
      set scrolloff=8     " keep 8 lines visible above/below cursor when scrolling

      " --- Indentation ---
      set tabstop=4       " a tab character appears as 4 spaces wide
      set shiftwidth=4    " when you press >>, indent by 4 spaces
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
      " GROWTH AREA: install a plugin like `catppuccin` or `tokyonight`
      " for a much more polished look.
      colorscheme habamax

      " --- Quality of Life ---
      set mouse=a         " enable mouse support (click to move cursor, scroll)
      set undofile        " remember undo history even after closing a file
      set splitright      " when you split a window, open new one on the right
      set splitbelow      " when you split horizontally, open new one below
    '';
  };

  # ---------------------------------------------------------------------------
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

  # ---------------------------------------------------------------------------
  # home-manager manages itself. Always keep this.
  # ---------------------------------------------------------------------------
  programs.home-manager.enable = true;
}
