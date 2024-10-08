return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    vim.keymap.set('n', '<Leader>dk', dap.up, { desc = 'Debug: Go up in current stacktrace without stepping. ' })
    vim.keymap.set('n', '<Leader>dj', dap.down, { desc = 'Debug: Go down in current stacktrace without stepping. ' })
    vim.keymap.set('n', '<Leader>drf', dap.restart_frame, { desc = 'Debug: Restart Frame' })
    vim.keymap.set('n', '<Leader>dC', dap.run_to_cursor, { desc = 'Debug: run to cursor' })
    vim.keymap.set('n', '<Leader>dRo', dap.repl.open, { desc = 'open repl' })
    vim.keymap.set('n', '<Leader>dRc', dap.repl.close, { desc = 'close repl' })
    vim.keymap.set('n', '<Leader>dRR', dap.repl.toggle, { desc = 'toggle repl' })
    vim.keymap.set('n', '<Leader>dd', dap.run_last, { desc = 'Debug: run last' })
    vim.keymap.set('n', '<Leader>dm', ":RustLsp debuggables ", { desc = 'RustLsp' })
    vim.keymap.set('n', '<Leader>drs', dap.restart, { desc = 'Debug: Restart Session' })
    vim.keymap.set('n', '<Leader>dq', dap.terminate, { desc = 'Debug: Terminate' })
    vim.keymap.set('n', '<Leader>dbe', dap.set_exception_breakpoints, { desc = 'Debug: set exception breakpoints' })
    vim.keymap.set('n', '<Leader>dbc', dap.clear_breakpoints, { desc = 'Debug: breakpoints clear' })
    vim.keymap.set('n', '<Leader>dbl', dap.list_breakpoints, { desc = 'Debug: breakpoints list' })
    vim.keymap.set('n', '<Leader>df', dap.focus_frame, { desc = 'Debug: focus frame' })

    vim.keymap.set('n', '<F5>', 
        function()
            -- (Re-)reads launch.json if present
            if vim.fn.filereadable(".vscode/launch.json") then
                require("dap.ext.vscode").load_launchjs(nil, {rust = {"rust", "rs"}})
            end
            require("dap").continue()
        end,
      { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<S-<F11>>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = 'Debug: toggle Breakpoint' })
    vim.keymap.set('n', '<S-<F9>>', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

  vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
