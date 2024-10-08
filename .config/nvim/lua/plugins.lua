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
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },

  "ii14/neorepl.nvim",

  {
    "folke/neoconf.nvim",
    opts = {}
  },
  {
    'neovim/nvim-lspconfig',
    -- config = function() require "lsp" end,
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

  -- Useful plugin to show you pending keybinds.
  {                     -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()
      -- Document existing key chains
      -- require('which-key').register {
      --   ['<leader>l'] = { name = '[l]sp', _ = 'which_key_ignore' },
      --   ['<leader>f'] = { name = '[f]ind', _ = 'which_key_ignore' },
      --   ['<leader>h'] = { name = '[h]arpoon', _ = 'which_key_ignore' },
      --   ['<leader>G'] = { name = '[G]it', _ = 'which_key_ignore' },
      --   ['<leader>W'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      -- }
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        -- theme = 'onedark',
        component_separators = '|',
        section_separators = '',
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
    config = function()
      vim.g.rustaceanvim = {
        dap = {
          autoload_configurations = true
        },
        completion = {
          snippets = {
            custom = {},
          },
        },
        --       imports = {
        --         granularity = {
        --           group = "module",
        --         },
        --         prefix = "self",
        --       },
        cargo = {
          buildScripts = {
            enable = true,
          },
          extraArgs = { "--target-dir=target/analyzer" },
        },
        procMacro = {
          enable = true
        },
        server = {
          extraEnv = { CARGO_TARGET_DIR = "target/analyzer" },
        },
        check = {
          command = "clippy"
        },
        workspace = {
          symbol = {
            search = {
              kind = "all_symbols",
            },
          },
        },
      }
    end
  },

  {
    "mhanberg/output-panel.nvim",
    event = "VeryLazy",
    config = function()
      require("output_panel").setup()
    end
  },
  'mbbill/undotree',
  -- 'gbprod/phpactor.nvim',


  require 'plugs.gitsigns',
  require 'plugs.oil',
  require("plugs.presence"),
  -- require 'plugs.rest',

  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.autoformat',

}, {}
)

require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippet" } })
