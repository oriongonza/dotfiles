-- Terminal Tab Management Feature
-- Provides Alt+t to toggle between terminal tab and working tab

local M = {}

function M.setup()
  vim.g.terminal_tab = 2
  vim.g.working_tab = 1

  function OpenTerminalInTab()
    local target_tab = vim.g.terminal_tab
    local current_tab = vim.fn.tabpagenr()

    if current_tab ~= target_tab then
      vim.g.previous_tab = current_tab
    end

    local tab_count = vim.fn.tabpagenr('$')
    if tab_count < target_tab then
      for _ = tab_count, target_tab - 1 do
        vim.cmd("tabnew")
      end
    end

    vim.cmd("tabnext " .. target_tab)

    if vim.bo.buftype ~= "terminal" then
      vim.cmd("terminal")
    end
  end

  function ReturnToPreviousTab()
    vim.cmd("tabnext " .. vim.g.previous_tab)
  end

  vim.keymap.set("n", "<M-t>", OpenTerminalInTab, { noremap = true, silent = true, desc = "Open terminal in dedicated tab" })
  vim.keymap.set("t", "<M-t>", ReturnToPreviousTab, { noremap = true, silent = true, desc = "Return to previous tab" })
end

return M
