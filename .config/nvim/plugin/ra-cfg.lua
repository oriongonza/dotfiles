vim.g.rustaceanvim = {
  tools = {
    enable_clippy = false,
    enable_nextest = true,
  },
  dap = {
    autoload_configurations = false
  },
  procMacro = {
    enable = false
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

local rsmap = function(keys, func)
  vim.keymap.set('n', '<leader>m' .. keys, ':RustLsp ' .. func .. '<CR>', { desc = func })
end

-- Rust keymaps start with <leader>m
rsmap('l', 'logFile')
rsmap('l', "logFile")
rsmap('r', "run")
rsmap('s', "workspaceSymbol")
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

-- local ramap = function(keys, func)
--   vim.keymap.set('n', '<leader>m' .. keys, ':RustAnalyzer ' .. func .. '<CR>', { desc = func })
-- end
-- ramap('rr', "restart")
-- ramap('rs', "reloadSettings")

vim.g.rust_check_with = "check"
vim.keymap.set("n", "<leader>moc", function()
    vim.g.rustaceanvim.tools.enable_clippy = not vim.g.rustaceanvim.tools.enable_clippy
    vim.cmd("RustAnalyzer restart")
  end,
  { desc = "Rust: toggle clippy" })
