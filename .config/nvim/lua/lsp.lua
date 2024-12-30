require("neoconf").setup()
require('lazydev').setup()
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

local lspcfg = require('lspconfig')

lspcfg.lua_ls.setup({
  Lua = {
    workspace = { checkThirdParty = false },
    telemetry = { enable = false },
  },
})

lspcfg.html.setup({ filetypes = { 'html', 'twig', 'hbs' }, })
lspcfg.ts_ls.setup({})
lspcfg.dockerls.setup({ filetypes = { 'Dockerfile' } })
lspcfg.nil_ls.setup({})
lspcfg.clangd.setup({})
lspcfg.phpactor.setup({})
lspcfg.tailwindcss.setup({ autostart = true })
lspcfg.svelte.setup({})
