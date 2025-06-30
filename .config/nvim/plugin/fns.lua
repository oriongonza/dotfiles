vim.api.nvim_create_user_command('Date', function(opts)
  local arg = opts.args:lower()
  local format_str

  if arg == 'time' then
    format_str = '%Y %b %d, %H:%M:%S' -- Date and time
  elseif arg == 'timeonly' then
    format_str = '%H:%M:%S'           -- Time only
  else
    format_str = '%Y %b %d'           -- Default: Date only
  end

  -- Insert the formatted date/time using :put
  local s = vim.fn.strftime(format_str)
  vim.api.nvim_put({ s }, 'l', true, false)
end, {
  nargs = '?',                    -- Accepts 0-1 arguments
  complete = function()
    return { 'time', 'timeonly' } -- Auto-completion options
  end,
  desc = "Insert date/time: [time] = date+time, [timeonly] = time only"
})
