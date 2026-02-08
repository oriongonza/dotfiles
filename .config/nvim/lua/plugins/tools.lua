-- Utility tools
return {
  -- Mason (LSP installer)
  {
    "williamboman/mason.nvim",
    config = function()
      require('mason').setup({})
    end
  },

  -- Neoconf
  {
    "folke/neoconf.nvim",
    dependencies = { 'folke/neodev.nvim' },
    opts = {}
  },

  -- Neorepl
  "ii14/neorepl.nvim",

  -- Fidget (LSP progress)
  {
    "j-hui/fidget.nvim",
    opts = {},
  },

  -- Undotree
  'mbbill/undotree',

  -- Neorg (note taking)
  {
    "nvim-neorg/neorg",
    lazy = false,
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/repos/notes",
              },
              default_workspace = "notes",
            },
          },
        }
      })

      local neorg_map = function(keys, func)
        vim.keymap.set("n", "<leader>n" .. keys, ":Neorg " .. func, { desc = "neorg: " .. func })
      end

      neorg_map("w", "workspace<CR>")
      neorg_map("W", "workspace ")
      neorg_map("i", "index<CR>")
      neorg_map("r", "return<CR>")
      neorg_map("n", "return<CR>")
      vim.keymap.set("n", "<leader>nn", ":e  ~/repos/notes/gtd/inbox.norg<CR>", {})
      vim.keymap.set("n", "<leader>ni", ":e  ~/repos/notes/index.norg<CR>", {})
    end
  },

  -- Discord presence
  {
    'IogaMaster/neocord',
    opts = {
      auto_update = true,
      neovim_image_text = "Average neovim enjoyer",
      main_image = "neovim",
      client_id = "793271441293967371",
      log_level = "warn",
      debounce_timeout = 5,
      enable_line_number = false,
      blacklist = {},
      buttons = true,
      file_assets = {},
      show_time = true,

      editing_text = function(filename)
        local pwd = vim.fn.getcwd()
        local is_work = pwd:match("/work[/$]")
        if is_work then
          return "Check us out at proton.me!"
        end

        if string.sub(filename, -3) == ".rs" then
          return "Oxidizing " .. filename
        end
        if filename == "Cargo.toml" then
          return "Oxidizing the configuration"
        end

        if string.sub(filename, -4) == ".lua" then
          return "Configuring " .. filename
        end

        if string.sub(filename, -3) == ".md" then
          return "Writing docs " .. filename
        end
        return "Editing " .. filename
      end,

      file_explorer_text = "Browsing %s",
      git_commit_text = "Committing changes",
      plugin_manager_text = "Managing plugins",
      reading_text = "Reading %s",
      workspace_text = function(name)
        if name == "nvim" then
          return "Wasting time on my config"
        end

        if name == "rust" then
          return "Hacking away at the compiler!"
        end

        local pwd = vim.fn.getcwd()
        local is_work = pwd:match("/work[/$]")
        if is_work then
          return "Working on protonmail"
        end

        if name == "" or name == nil then
          local ws = pwd:match("^.+/(.+)/?$")
          if ws == "" then
            return "I hope you're having a great day :)"
          end
          return name
        end
        return "Working on " .. name
      end,
      line_number_text = "Line %s/%s",
    }
  },
}
