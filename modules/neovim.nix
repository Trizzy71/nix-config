{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = false;

    plugins = with pkgs.vimPlugins; [
      tokyonight-nvim
      lualine-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      gitsigns-nvim
      nvim-web-devicons
    ];

    extraConfig = ''
      set number
      set relativenumber
      set cursorline
      set wrap
      set scrolloff=5
      set tabstop=2
      set shiftwidth=2
      set expandtab
      set smartindent
      set ignorecase
      set smartcase
      set hlsearch
      set incsearch
      set clipboard=unnamedplus
      set mouse=a
      set undofile
      set splitright
      set splitbelow
    '';

    initLua = ''
      -- colorscheme
      require("tokyonight").setup({ style = "night" })
      vim.cmd("colorscheme tokyonight")

      -- statusline
      require("lualine").setup({
        options = {
          theme = "tokyonight",
          icons_enabled = true,
        }
      })

      -- telescope
      require("telescope").setup({})
      require("telescope").load_extension("fzf")
      vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files)
      vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep)
      vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers)

      -- gitsigns
      require("gitsigns").setup()
    '';
  };
}
