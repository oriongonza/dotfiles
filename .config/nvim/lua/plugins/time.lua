-- Time insertion feature as a plugin dependency (for lazy loading)
return {
  'nvim-lua/plenary.nvim',  -- Dummy dependency to load the feature
  config = function()
    -- Feature is loaded in features/init.lua
  end
}
