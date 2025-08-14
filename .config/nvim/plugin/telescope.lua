-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    file_ignore_patterns = { ".git/", "node_modules/", "target/", "%.snap" },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },

    layout_config = {
      width  = 99999,
      height = 99999
    },
    layout_strategy = 'horizontal',
    path_display = "smart",
    border = false,
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

require('treesitter-cfg')

-- See `:help telescope.builtin`

local function get_desc(fn_or_name, desc)
  if desc then return desc else return fn_or_name end
end

local tbi = require('telescope.builtin')
local function tscope(key, f, desc)
  vim.keymap.set('n', '<leader>f' .. key, tbi[f], { desc = '[f]ind ' .. get_desc(f, desc) })
end

local function tscope_dropdown(key, f, desc)
  vim.keymap.set('n', '<leader>f' .. key, function()
    tbi[f](
      require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      }
    )
  end, { desc = '[f]ind ' .. get_desc(f, desc) })
end

tscope_dropdown('/', 'current_buffer_fuzzy_find', '[/] fuzzy find in current buffer')

local function tscope_fn(key, fn, desc)
  vim.keymap.set('n', '<leader>f' .. key, fn, { desc = '[f]ind ' .. get_desc(fn, desc) })
end

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

local function tscope_lsp(key, f, desc)
  local fn = require('telescope.builtin')[f]
  vim.keymap.set('n', 'g' .. key, fn, { desc = '[G]o to ' .. get_desc(f, desc) })
end

tscope_lsp('d', "lsp_definitions", '[d]efinition')
tscope_lsp('i', "lsp_implementations", '[i]mplementation')
tscope_lsp('t', "lsp_type_definitions", '[t]ype [d]efinition')
tscope_lsp('r', "lsp_references", '[r]eferences')
tscope_lsp('z', "lsp_incoming_calls", 'incoming calls')
tscope_lsp('Z', "lsp_outgoing_calls", 'lsp_outgoing_calls')
tscope_lsp('s', "lsp_workspace_symbols", 'lsp_workspace_symbols')
tscope_lsp('S', "lsp_document_symbols", 'lsp_document_symbols')
