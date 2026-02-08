-- Editor enhancement plugins
return {
  -- Surround text objects
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },

  -- Auto pairs
  {
    'windwp/nvim-autopairs',
    config = true
  },

  -- Auto close/rename HTML tags
  {
    'windwp/nvim-ts-autotag',
    opts = {}
  },

  -- Repeat plugin commands with .
  'tpope/vim-repeat',

  -- Enhanced date/time incrementing
  'tpope/vim-speeddating',

  -- Session management
  'tpope/vim-obsession',

  -- Commenting
  {
    'numToStr/Comment.nvim',
    opts = {}
  },
}
