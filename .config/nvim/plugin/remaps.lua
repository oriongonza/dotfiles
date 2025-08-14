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

require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function()
    vim.keymap.set('n', '<leader>la', "<cmd>AerialToggle<CR>", { desc = '[a]erial ' })
  end,
})


-- {{{ execute any `g` command in a new vsplit
vim.keymap.set('n', 'gw', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w><C-v>', true, false, true), 'n', false)
  vim.api.nvim_feedkeys('g', 'm', false)
end, { noremap = true, silent = true })
-- }}}

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

nmap('<leader>v', ':vs<CR>', '[v]ertical split')

vim.keymap.set({ 'n', 'v' }, '<C-z>', '<C-a>')

nmap('<leader>o', ':Oil<CR>', '[o]pen tree')
nmap('<leader>O', require("oil").open_float, '[o]pen tree')
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


local function get_desc(fn_or_name, desc)
  if desc then return desc else return fn_or_name end
end
-- {{{ LSP
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

tscope_lsp('d', "lsp_definitions", '[d]efinition')
tscope_lsp('i', "lsp_implementations", '[i]mplementation')
tscope_lsp('t', "lsp_type_definitions", '[t]ype [d]efinition')
tscope_lsp('r', "lsp_references", '[r]eferences')
tscope_lsp('z', "lsp_incoming_calls", 'incoming calls')
tscope_lsp('Z', "lsp_outgoing_calls", 'lsp_outgoing_calls')
tscope_lsp('s', "lsp_workspace_symbols", 'lsp_workspace_symbols')
tscope_lsp('S', "lsp_document_symbols", 'lsp_document_symbols')

-- }}}

-- {{{ Harpoon
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

-- }}}

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


vim.keymap.set('n', '<Leader>lih', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end)
