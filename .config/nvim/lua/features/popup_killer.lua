-- Popup Killer Feature
-- Closes all floating windows and clears search highlight on Esc

local M = {}

local function getPopups()
  return vim.fn.filter(vim.api.nvim_tabpage_list_wins(0),
    function(_, e) return vim.api.nvim_win_get_config(e).zindex end)
end

local function killPopups()
  vim.fn.map(getPopups(), function(_, e)
    vim.api.nvim_win_close(e, false)
  end)
end

function M.setup()
  -- Clear search highlight & kill popups on Esc
  vim.keymap.set("n", "<Esc>", function()
    vim.cmd.noh()
    killPopups()
  end, { desc = "Clear search and close popups" })
end

return M
