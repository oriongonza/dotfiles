-- Custom Commands Feature
-- Provides useful utility commands

local M = {}

function M.setup()
  -- Reload Neovim configuration
  vim.api.nvim_create_user_command('Resource', function()
    vim.cmd('luafile $MYVIMRC')
  end, { desc = "Reload Neovim configuration" })

  -- Edit Neovim configuration
  vim.api.nvim_create_user_command('Config', function()
    vim.cmd('e $MYVIMRC')
  end, { desc = "Edit Neovim configuration" })

  -- Copy current file path to clipboard
  vim.api.nvim_create_user_command('CpPath', function()
    vim.fn.setreg('+', vim.fn.expand('%'))
    print('Copied path: ' .. vim.fn.expand('%'))
  end, { desc = "Copy current file path to clipboard" })
end

return M
