-- LSP configuration (orchestrator)
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
    'folke/lazydev.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    -- Setup neoconf and lazydev first
    require("neoconf").setup()
    require('lazydev').setup()

    local lsp_zero = require('lsp-zero')

    -- Setup on_attach with unified keymaps
    lsp_zero.on_attach(function(client, bufnr)
      -- Default LSP keymaps from lsp-zero
      lsp_zero.default_keymaps({ buffer = bufnr })
      -- Additional custom keymaps (unified across all LSP servers)
      require('plugins.lsp.keymaps').setup(bufnr)
    end)

    -- Setup capabilities with nvim-cmp integration
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Load and configure all servers
    local servers = require('plugins.lsp.servers')
    local lspconfig = require('lspconfig')
    
    for server, config in pairs(servers) do
      lspconfig[server].setup(vim.tbl_extend('force', {
        capabilities = capabilities
      }, config))
    end
  end
}
