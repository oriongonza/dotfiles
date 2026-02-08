-- thinking.lua
-- Quick journaling helpers. Inserts timestamped entry and enters insert mode.
-- Output: "2025-01-25 14:32 thought "
--
-- Usage: require("thinking")

local function setup_thoughts()
  local kinds = {
    { key = "t", name = "thought" },
    { key = "j", name = "journal" },
    { key = "g", name = "judgement" },
    { key = "i", name = "insight" },
  }

  local function insert_entry(kind)
    local ts = os.date("%Y-%m-%d %H:%M")
    local line = ts .. " " .. kind .. " "
    vim.api.nvim_put({ "", line }, "l", true, true)
    vim.cmd("startinsert!")
  end

  for _, k in ipairs(kinds) do
    vim.keymap.set("n", "<leader>ct" .. k.key, function() insert_entry("(" .. k.name .. ")") end, { desc = k.name })
  end
end


setup_thoughts()
