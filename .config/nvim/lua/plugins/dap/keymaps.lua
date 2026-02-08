-- DAP keymaps
local M = {}

function M.setup(dap, dapui)
  -- DAP control keymaps
  vim.keymap.set('n', '<Leader>dk', dap.up, { desc = 'Debug: Go up in stacktrace' })
  vim.keymap.set('n', '<Leader>dj', dap.down, { desc = 'Debug: Go down in stacktrace' })
  vim.keymap.set('n', '<Leader>drf', dap.restart_frame, { desc = 'Debug: Restart Frame' })
  vim.keymap.set('n', '<Leader>dC', dap.run_to_cursor, { desc = 'Debug: run to cursor' })
  vim.keymap.set('n', '<Leader>dRo', dap.repl.open, { desc = 'Debug: open repl' })
  vim.keymap.set('n', '<Leader>dRc', dap.repl.close, { desc = 'Debug: close repl' })
  vim.keymap.set('n', '<Leader>dRR', dap.repl.toggle, { desc = 'Debug: toggle repl' })
  vim.keymap.set('n', '<Leader>dd', dap.run_last, { desc = 'Debug: run last' })
  vim.keymap.set('n', '<Leader>dm', ":RustLsp debuggables ", { desc = 'Debug: RustLsp debuggables' })
  vim.keymap.set('n', '<Leader>drs', dap.restart, { desc = 'Debug: Restart Session' })
  vim.keymap.set('n', '<Leader>dq', dap.terminate, { desc = 'Debug: Terminate' })
  vim.keymap.set('n', '<Leader>df', dap.focus_frame, { desc = 'Debug: focus frame' })

  -- Breakpoint keymaps
  vim.keymap.set('n', '<Leader>dbe', dap.set_exception_breakpoints, { desc = 'Debug: set exception breakpoints' })
  vim.keymap.set('n', '<Leader>dbc', dap.clear_breakpoints, { desc = 'Debug: breakpoints clear' })
  vim.keymap.set('n', '<Leader>dbl', dap.list_breakpoints, { desc = 'Debug: breakpoints list' })

  -- Function keys for debugging
  vim.keymap.set('n', '<F5>', function()
    -- Load launch.json if present
    if vim.fn.filereadable(".vscode/launch.json") then
      require("dap.ext.vscode").load_launchjs(nil, {rust = {"rust", "rs"}})
    end
    require("dap").continue()
  end, { desc = 'Debug: Start/Continue' })
  
  vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
  vim.keymap.set('n', '<S-<F11>>', dap.step_out, { desc = 'Debug: Step Out' })
  vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
  vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = 'Debug: toggle Breakpoint' })
  vim.keymap.set('n', '<S-<F9>>', function()
    dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
  end, { desc = 'Debug: Set Breakpoint' })

  -- DAP UI toggle
  vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result' })
end

return M
