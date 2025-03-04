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
