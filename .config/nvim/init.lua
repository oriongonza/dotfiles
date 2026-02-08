vim.g.mapleader = ' '

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
vim.opt.rtp:prepend(lazypath)

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end

require('lazy').setup({
  {
    "williamboman/mason.nvim",
    config = function() require('mason').setup({}) end
  },
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb', --GitHub
  'tpope/vim-sleuth',
  'tpope/vim-repeat',
  'tpope/vim-speeddating',
  'tpope/vim-obsession',

  {
    "rbong/vim-flog",
    lazy = true,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
      "tpope/vim-fugitive",
    },
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function() require("nvim-surround").setup({}) end
  },

  {
    'windwp/nvim-autopairs',
    config = true
  },

  {
    'windwp/nvim-ts-autotag',
    opts = {}
  },

  "ii14/neorepl.nvim",

  {
    "folke/neoconf.nvim",
    dependencies = { 'folke/neodev.nvim' },
    opts = {}
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
      'folke/lazydev.nvim',
    },
  },

  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp'
      },

      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      -- 'rafamadriz/friendly-snippets',
    },
  },

  {
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()
      -- Document existing key chains
      require('which-key').register =
      {
        { "<leader>G",  group = "[G]it" },
        { "<leader>G_", hidden = true },
        { "<leader>W",  group = "[W]orkspace" },
        { "<leader>W_", hidden = true },
        { "<leader>f",  group = "[f]ind" },
        { "<leader>f_", hidden = true },
        { "<leader>h",  group = "[h]arpoon" },
        { "<leader>h_", hidden = true },
        { "<leader>l",  group = "[l]sp" },
        { "<leader>l_", hidden = true },
      }
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        component_separators = '|',
        -- section_separators = '',
      },
    },
  },
  "projekt0n/github-nvim-theme",

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },

  { 'numToStr/Comment.nvim',    opts = {} },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    opts =
    {
      setup = {
        pickers = {
          find_files = {
            hidden = true,
            file_ignore_patterns = { ".git/" },
          }
        }
      }
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
  },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  'stevearc/aerial.nvim',

  'nvim-neotest/nvim-nio',

  {
    'mrcjkb/rustaceanvim',
    lazy = false,
  },

  'mbbill/undotree',

  {
    "nvim-neorg/neorg",
    lazy = false,
  },

  require 'plugs.gitsigns',
  require 'plugs.oil',
  require("plugs.presence"),
  -- require 'plugs.rest',

  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.autoformat',

}, {}
)

require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippet" } })

-- Load the per-dir-cfg code
require("system.per_dir_cfg").setup()
