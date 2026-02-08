-- UI plugins
return {
  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        component_separators = '|',
      },
    },
  },

  -- Indent guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },

  -- Which-key (keymap hints)
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()
      -- Register key groups
      require('which-key').add({
        { "<leader>G",  group = "[G]it" },
        { "<leader>G_", hidden = true },
        { "<leader>W",  group = "[W]orkspace" },
        { "<leader>W_", hidden = true },
        { "<leader>f",  group = "[f]ind" },
        { "<leader>f_", hidden = true },
        { "<leader>h",  group = "[h]arpoon" },
        { "<leader>h_", hidden = true },
        { "<leader>l",  group = "[l]sp" },
        { "<leader>l_", hidden = true },
        { "<leader>m",  group = "rust" },
        { "<leader>m_", hidden = true },
        { "<leader>n",  group = "[n]eorg" },
        { "<leader>n_", hidden = true },
        { "<leader>t",  group = "[t]ime" },
        { "<leader>t_", hidden = true },
        { "<leader>d",  group = "[d]ebug" },
        { "<leader>d_", hidden = true },
      })
    end,
  },

  -- Aerial (code outline)
  {
    'stevearc/aerial.nvim',
    config = function()
      require("aerial").setup({
        on_attach = function()
          vim.keymap.set('n', '<leader>la', "<cmd>AerialToggle<CR>", { desc = '[a]erial' })
        end,
      })
    end
  },

  -- GitHub theme
  "projekt0n/github-nvim-theme",
}
