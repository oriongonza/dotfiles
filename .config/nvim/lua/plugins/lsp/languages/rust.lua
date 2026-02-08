-- Rust-specific LSP configuration (rustaceanvim)
return {
  'mrcjkb/rustaceanvim',
  lazy = false,
  config = function()
    vim.g.rustaceanvim = {
      tools = {
        enable_clippy = os.getenv("RA_CLIPPY") ~= true,
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

    -- Rust keymaps start with <leader>m
    local rsmap = function(keys, func)
      vim.keymap.set('n', '<leader>m' .. keys, ':RustLsp ' .. func .. '<CR>', { desc = func })
    end

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

    vim.g.rust_check_with = "check"
    vim.keymap.set("n", "<leader>moc", function()
      vim.g.rustaceanvim.tools.enable_clippy = not vim.g.rustaceanvim.tools.enable_clippy
      vim.cmd("RustAnalyzer restart")
    end, { desc = "Rust: toggle clippy" })
  end
}
