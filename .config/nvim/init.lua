-- Neovim configuration entry point
-- Modular architecture with clear separation of concerns

-- Set leader key before lazy.nvim
vim.g.mapleader = ' '

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load core configuration (options, autocmds, keymaps)
require('config')

-- Load plugins (lazy.nvim auto-imports from lua/plugins/)
require('lazy').setup({ import = 'plugins' }, {})

-- Load custom features (non-plugin configurations)
require('features')

-- Load snippets
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippet" } })

-- Load project-specific configs
require("system.per_dir_cfg").setup()
