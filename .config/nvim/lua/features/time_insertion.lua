-- Time Insertion Feature
-- Provides keymaps to insert various time/date formats at cursor position

local M = {}

function M.setup()
  local time_fns = {
    x = { fmt = "%Y-%m-%d %H:%M:%S", name = "timestamp" },
    d = { fmt = "%Y-%m-%d", name = "date" },
    t = { fmt = "%H:%M:%S", name = "time" },
    w = { fmt = "%A", name = "weekday" },
    i = { fmt = "%Y%m%d%H%M%S", name = "sortable" },
    u = { fmt = "%s", name = "unix epoch" },
  }

  for key, opts in pairs(time_fns) do
    vim.keymap.set("n", "<leader>t" .. key, function()
      vim.api.nvim_put({ os.date(opts.fmt) }, "c", true, true)
    end, {
      desc = string.format("Time: %s → %s", opts.name, os.date(opts.fmt))
    })
  end
end

return M
