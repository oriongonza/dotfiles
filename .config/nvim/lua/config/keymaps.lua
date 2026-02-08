-- Core editor keymaps (plugin-specific keymaps live with their plugins)
local helpers = require('core.helpers')
local nmap = helpers.nmap

-- Disable space in normal/visual mode (leader key)
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- File operations
nmap('<leader>w', ':w<CR>', '[w]rite file')
nmap('<leader>q', ':q<CR>', '[q]uit file')
nmap('<leader>x', ':wqa<CR>', 'e[x]it nvim')
nmap('<leader>v', ':vs<CR>', '[v]ertical split')

-- Remap Ctrl-z to Ctrl-a (increment)
vim.keymap.set({ 'n', 'v' }, '<C-z>', '<C-a>')

-- Clipboard paste in command mode
vim.keymap.set('c', '<C-v>', '<C-r>+')

-- Better line navigation
vim.keymap.set({ 'n', 'v' }, 'L', '$', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'H', '^', { silent = true })

-- Better yank and paste
vim.keymap.set({ 'n', 'v' }, 'Y', 'y$')
vim.keymap.set('v', 'p', '"_dP')

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Window resize
vim.keymap.set({ 'n', 'v' }, '<Up>', ':horizontal resize -2<CR>')
vim.keymap.set({ 'n', 'v' }, '<Down>', ':horizontal resize +2<CR>')
vim.keymap.set({ 'n', 'v' }, '<Right>', ':vertical resize -2<CR>')
vim.keymap.set({ 'n', 'v' }, '<Left>', ':vertical resize +2<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
