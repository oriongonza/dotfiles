-- vim.cmd.colorscheme("default")
--vim.cmd.colorscheme("rose-pine")
-- vim.cmd.colorscheme("github_dark")


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


-- If theme = nil then rotate,
local function set_theme(theme)
  if theme == "default" then
    default_theme()
  elseif theme == "dark" then
    dark_theme()
  elseif theme == "light" then
    light_theme()
  elseif theme == nil then
    set_theme(next_theme)
  end
end

vim.api.nvim_create_user_command("Colorscheme", function(opts)
  set_theme(opts.args)
end, { nargs = '?' })

dark_theme()
