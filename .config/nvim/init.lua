vim.g.mapleader = ' '
vim.g.maplocalleader = ','

require("plugins")
require("options")
require("keymaps")
require("lsp")
require("cmp-cfg")
require("colors")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
