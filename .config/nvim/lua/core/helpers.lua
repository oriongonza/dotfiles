-- Shared helper functions used across the configuration
local M = {}

-- Get description for keymaps - returns desc if provided, otherwise fn_or_name
function M.get_desc(fn_or_name, desc)
  if desc then
    return desc
  else
    return fn_or_name
  end
end

-- Normal mode keymap helper
function M.nmap(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = desc })
end

return M
