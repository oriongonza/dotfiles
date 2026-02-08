-- Navigation plugins (Telescope, Oil, Harpoon)
local helpers = require('core.helpers')
local nmap = helpers.nmap

return {
  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup({
        defaults = {
          file_ignore_patterns = { ".git/", "node_modules/", "target/", "%.snap", "3rdparty", ".venv/" },
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
          layout_config = {
            width = 99999,
            height = 99999
          },
          layout_strategy = 'horizontal',
          path_display = "smart",
          border = false,
        },
      })

      -- Enable extensions
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- Keymaps
      local tbi = require('telescope.builtin')
      local get_desc = helpers.get_desc

      local function tscope(key, f, desc)
        vim.keymap.set('n', '<leader>f' .. key, tbi[f], { desc = '[f]ind ' .. get_desc(f, desc) })
      end

      local function tscope_dropdown(key, f, desc)
        vim.keymap.set('n', '<leader>f' .. key, function()
          tbi[f](require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end, { desc = '[f]ind ' .. get_desc(f, desc) })
      end

      local function tscope_fn(key, fn, desc)
        vim.keymap.set('n', '<leader>f' .. key, fn, { desc = '[f]ind ' .. get_desc(fn, desc) })
      end

      tscope_dropdown('/', 'current_buffer_fuzzy_find', '[/] fuzzy find in current buffer')
      tscope('G', 'git_files', '[g]it files')
      tscope('w', 'grep_string', '[w]ord')
      tscope('g', 'live_grep', 'by [g]rep')
      tscope('d', 'diagnostics', '[d]iagnostics')
      tscope('H', 'help_tags', '[h]elp')
      tscope('h', 'find_files', 'ignore [h]idden files')
      tscope('o', 'oldfiles', '[o]ld files')
      tscope('b', 'builtin', '[b]uiltin')
      tscope('c', 'commands')
      tscope('k', 'keymaps')
      tscope('m', 'marks')
      tscope('s', 'symbols')
      tscope('?', 'search_history')
      tscope('r', 'resume')

      tscope_fn('f', function() tbi.find_files({ hidden = true, no_ignore = true }) end, "[f]ile")
      tscope_fn('i', function() tbi.find_files({ hidden = false, no_ignore = false }) end, "[i]gnored")
      tscope_fn('n', function() tbi.find_files { cwd = vim.fn.stdpath 'config' } end, "[n]eovim files")
    end
  },

  -- Oil (file explorer)
  {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = true,
      columns = {
        "icon",
      },
      buf_options = {
        buflisted = false,
        bufhidden = "hide",
      },
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },
      delete_to_trash = false,
      skip_confirm_for_simple_edits = false,
      prompt_save_on_select_new_entry = true,
      cleanup_delay_ms = 2000,
      lsp_file_methods = {
        timeout_ms = 1000,
        autosave_changes = false,
      },
      constrain_cursor = "editable",
      experimental_watch_for_changes = false,
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
      use_default_keymaps = true,
      view_options = {
        show_hidden = false,
        is_hidden_file = function(name, _)
          local hidden_rules = {
            ["node_modules"] = true,
            ["target"] = true,
            [".config"] = false,
            [".cargo"] = false,
            [".gitconfig"] = false,
            [".gitignore"] = false,
            [".gitmodules"] = false
          }
          if hidden_rules[name] ~= nil then
            return hidden_rules[name]
          end
          return vim.startswith(name, ".")
        end,
        is_always_hidden = function(name, bufnr)
          return false
        end,
        natural_order = true,
        sort = {
          { "type", "asc" },
          { "name", "asc" },
        },
      },
      extra_scp_args = {},
      float = {
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        override = function(conf)
          return conf
        end,
      },
      preview = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = 0.9,
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        update_on_cursor_moved = true,
      },
      progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        minimized_border = "none",
        win_options = {
          winblend = 0,
        },
      },
      ssh = {
        border = "rounded",
      },
      keymaps_help = {
        border = "rounded",
      },
    },
    config = function(_, opts)
      require('oil').setup(opts)
      -- Oil keymaps
      nmap('<leader>o', ':Oil<CR>', '[o]pen tree')
      nmap('<leader>O', require("oil").open_float, '[O]pen tree float')
    end
  },

  -- Harpoon (quick file navigation)
  {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    config = function()
      local harpoon = require("harpoon.ui")
      nmap('<Leader>ha', require("harpoon.mark").add_file, "[h]arpoon [a]dd file")
      nmap('<Leader>hm', harpoon.toggle_quick_menu, "[h]arpoon [m]enu")
      nmap('<Leader>hj', harpoon.nav_prev, "[h]arpoon go to previous")
      nmap('<Leader>hk', harpoon.nav_next, "[h]arpoon go to next")
      nmap('<A-1>', function() harpoon.nav_file(1) end, "harpoon go to 1")
      nmap('<A-2>', function() harpoon.nav_file(2) end, "harpoon go to 2")
      nmap('<A-3>', function() harpoon.nav_file(3) end, "harpoon go to 3")
      nmap('<A-4>', function() harpoon.nav_file(4) end, "harpoon go to 4")
      nmap('<A-5>', function() harpoon.nav_file(5) end, "harpoon go to 5")
      nmap('<A-6>', function() harpoon.nav_file(6) end, "harpoon go to 6")
      nmap('<A-7>', function() harpoon.nav_file(7) end, "harpoon go to 7")
      nmap('<A-8>', function() harpoon.nav_file(8) end, "harpoon go to 8")
      nmap('<A-9>', function() harpoon.nav_file(9) end, "harpoon go to 9")
      nmap('<A-0>', function() harpoon.nav_file(9) end, "harpoon go to 0")
    end
  },

  -- Todo comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false }
  },
}
