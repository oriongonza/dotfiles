-- gw Vsplit Feature
-- Execute any 'g' command in a new vertical split

local M = {}

function M.setup()
  vim.keymap.set('n', 'gw', function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w><C-v>', true, false, true), 'n', false)
    vim.api.nvim_feedkeys('g', 'm', false)
  end, { noremap = true, silent = true, desc = 'Execute g command in vsplit' })
end

return M
