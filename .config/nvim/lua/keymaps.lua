-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Telescope. See `:help telescope` and `:help telescope.setup()` TODO
require('telescope').setup {
  defaults = {
    file_ignore_patterns = { ".git/", },
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
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

require('treesitter-cfg')

-- See `:help telescope.builtin`

local function get_desc(f, desc)
  if desc then return desc else return f end
end

local tbi = require('telescope.builtin')
local function tscope(key, f, desc)
  local fn =
      vim.keymap.set('n', '<leader>f' .. key, tbi[f], { desc = '[f]ind ' .. get_desc(f, desc) })
end

local function tscope_drop(key, f, desc)
  vim.keymap.set('n', '<leader>f' .. key, function()
    tbi[f](
      require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      }
    )
  end, { desc = '[f]ind ' .. get_desc(f, desc) })
end

tscope_drop('/', 'current_buffer_fuzzy_find', '[/] fuzzy find in current buffer')

local function tscope_fn(key, fn, desc)
  vim.keymap.set('n', '<leader>f' .. key, fn, { desc = '[f]ind ' .. get_desc(f, desc) })
end

tscope('g', 'git_files', '[g]it files')
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

tscope_fn('f', function() tbi.find_files({ hidden = true, no_ignore = false }) end, "[f]ile")
tscope_fn('i', function() tbi.find_files({ hidden = false, no_ignore = true }) end, "[i]gnored")
tscope_fn('n', function() tbi.find_files { cwd = vim.fn.stdpath 'config' } end, "[n]eovim files")

require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    vim.keymap.set('n', '<leader>la', "<cmd>AerialToggle<CR>", { desc = '[a]erial ' })
  end,
})


-- execute any `g` command in a new vsplit
vim.keymap.set('n', 'gw', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w><C-v>', true, false, true), 'n', false)
  vim.api.nvim_feedkeys('g', 'm', false)
end, { noremap = true, silent = true })

local nmap = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = desc })
end

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

nmap('<leader>w', ':w<CR>', '[w]rite file')
nmap('<leader>q', ':q<CR>', '[q]uit file')
nmap('<leader>x', ':wqa<CR>', 'e[x]it nvim')
nmap('<leader>n', ':enew<CR>', '[n]ew buffer')

nmap('<leader>v', ':vs<CR>', '[v]ertical split')

vim.keymap.set({ 'n', 'v' }, '<C-z>', '<C-a>')

nmap('<leader>o', ':Oil<CR>', '[o]pen tree')
vim.keymap.set('c', '<C-v>', '<C-r>+')

vim.keymap.set({ 'n', 'v' }, 'L', '$', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'H', '^', { silent = true })

vim.keymap.set({ 'n', 'v' }, 'Y', 'y$')
vim.keymap.set('v', 'p', '"_dP')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })


vim.keymap.set({ 'n', 'v', }, '<Up>', ':horizontal resize -2<CR>')
vim.keymap.set({ 'n', 'v', }, '<Down>', ':horizontal resize +2<CR>')
vim.keymap.set({ 'n', 'v', }, '<Right>', ':vertical   resize -2<CR>')
vim.keymap.set({ 'n', 'v', }, '<Left>', ':vertical   resize +2<CR>')


vim.api.nvim_command('command! Resource luafile $MYVIMRC')
vim.api.nvim_command('command! Config e $MYVIMRC')
vim.api.nvim_command('command! CpPath call setreg("+", expand("%"))')


-- [[ Configure LSP ]]
local function tscope_lsp(key, f, desc)
  local fn = require('telescope.builtin')[f]
  vim.keymap.set('n', 'g' .. key, fn, { desc = '[G]o to ' .. get_desc(f, desc) })
end

vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, { desc = 'Move focus to the upper window' })

nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
nmap('<leader>r', vim.lsp.buf.rename, '[R]ename')
nmap('<leader>a', vim.lsp.buf.code_action, '[L]sp code [A]ction')
nmap('<leader>lf', vim.lsp.buf.format, '[L]sp [f]ormat')
nmap('<leader>lh', vim.lsp.buf.document_highlight, '[L]sp [h]ighlight')
nmap('<leader>lH', vim.lsp.buf.clear_references, '[L]sp [h]ighlight')
nmap('<leader>lr', ':LspRestart<CR>', '[L]sp [r]eload')

local rsmap = function(keys, func)
  vim.keymap.set('n', '<leader>m' .. keys, ':RustLsp ' .. func .. '<CR>', { desc = func })
end

-- Rust keymaps start with <leader>m
rsmap('l', 'logFile')
rsmap('l', "logFile")
rsmap('r', "run")
rsmap('s', "workspaceSymbol")
rsmap('r', "reloadWorkspace")
rsmap('d', "openDocs")
rsmap('a', "codeAction")
rsmap('m', "moveItem")
rsmap('j', "joinLines")
rsmap('t', "testables")
rsmap('d', "debuggables")
rsmap('epr', "rebuildProcMacro")
rsmap('ed', "externalDocs")
rsmap('et', "syntaxTree")
rsmap('ee', "explainError")
rsmap('em', "expandMacro")
rsmap('eg', "crateGraph")
rsmap('ef', "flyCheck")
rsmap('evh', "view hir")
rsmap('evm', "view mir")
rsmap('gp', "parentModule")
rsmap('c', "openCargo")
rsmap('K', "hover")
rsmap('er', "runnables")
rsmap('rd', "debug")
rsmap('s', "ssr")
rsmap('er', "renderDiagnostic")

tscope_lsp('d', "lsp_definitions", '[d]efinition')
tscope_lsp('i', "lsp_implementations", '[i]mplementation')
tscope_lsp('t', "lsp_type_definitions", '[t]ype [d]efinition')
tscope_lsp('r', "lsp_references", '[r]eferences')
tscope_lsp('z', "lsp_incoming_calls", 'incoming calls')
tscope_lsp('Z', "lsp_outgoing_calls", 'lsp_outgoing_calls')
tscope_lsp('s', "lsp_document_symbols", 'lsp_document_symbols')
tscope_lsp('S', "lsp_workspace_symbols", 'lsp_workspace_symbols')

-- [[ Harpoon ]]
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

local function getPopups()
  return vim.fn.filter(vim.api.nvim_tabpage_list_wins(0),
    function(_, e) return vim.api.nvim_win_get_config(e).zindex end)
end
local function killPopups()
  vim.fn.map(getPopups(), function(_, e)
    vim.api.nvim_win_close(e, false)
  end)
end
-- clear search highlight & kill popups
vim.keymap.set("n", "<Esc>", function()
  vim.cmd.noh()
  killPopups()
end)

local function goto_yanked_text()
  local yank_contents = vim.fn.getreg('"')
  -- todo
end

vim.keymap.set('n', 'gy', goto_yanked_text, { desc = "gF for yanked test" })

-- Create a Neovim command that calls the Lua function
vim.api.nvim_create_user_command('Goto', goto_yanked_text, {})

vim.keymap.set('n', '<Leader>lih', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end)
