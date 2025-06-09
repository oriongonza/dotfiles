vim.g.terminal_tab = 2 -- Define the fixed tab number for the terminal
vim.g.working_tab = 1  -- Store the previous tab number

-- Function to open the terminal in the fixed tab
function OpenTerminalInTab()
  local target_tab = vim.g.terminal_tab
  local current_tab = vim.fn.tabpagenr()

  if current_tab ~= target_tab then
    vim.g.previous_tab = current_tab -- Store the previous tab
  end

  -- Check if the target tab exists
  local tab_count = vim.fn.tabpagenr('$')
  if tab_count < target_tab then
    -- Open new tabs up to the target number
    for _ = tab_count, target_tab - 1 do
      vim.cmd("tabnew")
    end
  end

  -- Move to the target tab
  vim.cmd("tabnext " .. target_tab)

  -- If the buffer is not a terminal, open a new one
  if vim.bo.buftype ~= "terminal" then
    vim.cmd("terminal")
  end
end

-- Function to return to the previous tab
function ReturnToPreviousTab()
  vim.cmd("tabnext " .. vim.g.previous_tab)
end

-- Keybindings
vim.keymap.set("n", "<M-t>", OpenTerminalInTab, { noremap = true, silent = true })
vim.keymap.set("t", "<M-t>", ReturnToPreviousTab, { noremap = true, silent = true })
