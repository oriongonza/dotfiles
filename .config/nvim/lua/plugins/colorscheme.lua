-- Colorscheme plugin
-- Feature logic is in features/colorscheme_rotation.lua
return {
  "projekt0n/github-nvim-theme",
  config = function()
    -- Set initial theme
    require('features.colorscheme_rotation').set_initial_theme()
  end
}
