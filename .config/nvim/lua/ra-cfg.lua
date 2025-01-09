vim.g.rustaceanvim = {
  dap = {
    autoload_configurations = true
  },
  completion = {
    snippets = nil,
    -- snippets = {
    --   custom = {},
    -- },
  },
  --       imports = {
  --         granularity = {
  --           group = "module",
  --         },
  --         prefix = "self",
  --       },
  cargo = {
    targetDir = true,
    buildScripts = {
      enable = true,
    },
    extraArgs = { "--target-dir=target/analyzer" },
  },
  procMacro = {
    enable = true
  },
  server = {
    extraEnv = { CARGO_TARGET_DIR = "target/analyzer" },
  },
  check = {
    command = "check"
  },
  workspace = {
    symbol = {
      search = {
        kind = "all_symbols",
      },
    },
  },
  rustc = { source = "discover" },
  linkedProjects = {
    "./Cargo.toml",
    "clippy_dev/Cargo.toml",
    "lintcheck/Cargo.toml",
  }
}
