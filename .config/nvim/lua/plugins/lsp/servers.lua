-- LSP server configurations
return {
  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  },
  html = {
    filetypes = { 'html', 'twig', 'hbs' },
  },
  ts_ls = {},
  dockerls = {
    filetypes = { 'Dockerfile' }
  },
  nil_ls = {},
  clangd = {},
  phpactor = {},
  tailwindcss = {
    autostart = true
  },
  svelte = {},
  biome = {},
  sqls = {},
}
