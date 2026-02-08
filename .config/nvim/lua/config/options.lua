-- Vim options (merged from plugin/options.lua and plugin/vim/options.vim)

-- Nerd font support
vim.g.have_nerd_font = true

-- Disable swap files
vim.opt.swapfile = false

-- Search settings
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split'

-- UI settings
vim.opt.showmode = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true
vim.opt.scrolloff = 2
vim.opt.termguicolors = true
vim.opt.list = false
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Mouse and clipboard
vim.opt.mouse = 'nvi'
vim.opt.clipboard = 'unnamedplus'

-- Editing
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Completion
vim.opt.completeopt = 'menuone,noselect'

-- Timing
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Help window
vim.opt.helpheight = 99999

-- LSP inlay hints (disabled by default)
vim.lsp.inlay_hint.enable(false)
