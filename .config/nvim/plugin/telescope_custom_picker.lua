local actions      = require('telescope.actions')
local action_state = require('telescope.actions.state')
local conf         = require('telescope.config').values
local finders      = require('telescope.finders')
local sorters      = require('telescope.sorters')
local pickers      = require('telescope.pickers')
local make_entry   = require('telescope.make_entry')
local popups       = require('plenary.popup')
local popup        = require('plenary.popup')


local function bar(search_dirs)
  require("telescope.builtin").live_grep({
    search_dirs = search_dirs,
  })
end

local function foo()
  require("telescope.builtin").find_files({
    find_command = { "fd", "--type", "f", "--color", "never" },
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        --- @type Picker
        local picker = action_state.get_current_picker(prompt_bufnr)
        local search_dirs = {}

        for _, entry in ipairs(picker:get_multi_selection()) do
          local text = entry.text

          if not text then
            if type(entry.value) == "table" then
              text = entry.value.text
            else
              text = entry.value
            end
          end

          table.insert(search_dirs, text)
        end
        if search_dirs == {} then
          search_dirs = picker:get_selection()[1]
        end
        vim.print(search_dirs)
        bar(search_dirs)
      end)
      return true
    end
  })
end

vim.keymap.set('n', '<leader>fF', foo, { desc = '[f]ind fuzzy' })
