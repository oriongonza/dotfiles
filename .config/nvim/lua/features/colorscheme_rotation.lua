-- Colorscheme Rotation Feature
-- Cycle between default, dark, and light themes with :Colorscheme command

local M = {}

local next_theme = "default"

local function default_theme()
  vim.api.nvim_set_hl(0, "Normal", {})
  local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = normal.bg })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = normal.bg })
  vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none" })
  vim.api.nvim_set_hl(0, "CustomGroup", { bg = normal.bg })
  next_theme = "dark"
end

local function dark_theme()
  vim.cmd.colorscheme("github_dark")
  next_theme = "light"
end

local function light_theme()
  vim.cmd.colorscheme("github_light_high_contrast")
  next_theme = "default"
end

local function set_theme(theme)
  if theme == "default" then
    default_theme()
  elseif theme == "dark" then
    dark_theme()
  elseif theme == "light" then
    light_theme()
  elseif theme == nil or theme == "" then
    set_theme(next_theme)
  end
end

function M.setup()
  -- Create user command for theme rotation
  vim.api.nvim_create_user_command("Colorscheme", function(opts)
    set_theme(opts.args)
  end, { nargs = '?', desc = "Rotate or set colorscheme (default/dark/light)" })
end

function M.set_initial_theme()
  dark_theme()
end

return M
