-- per_dir_cfg.lua
-- Loads project-specific configs based on cwd path components.
--
-- For cwd /repos/sockudo/api:
--   -> loads per_project/repos.lua (if exists)
--   -> loads per_project/sockudo.lua (if exists)
--   -> loads per_project/api.lua (if exists)
--
-- Usage: require("per_dir_cfg").setup()

local M = {}

M.cfg_dir = vim.fn.stdpath("config") .. "/per_project"
local loaded = {}

function M.load_for_cwd()
  local cwd = vim.fn.getcwd()
  if loaded[cwd] then return end
  loaded[cwd] = true

  for _, name in ipairs(vim.split(cwd, "/", { trimempty = true })) do
    local path = M.cfg_dir .. "/" .. name .. ".lua"
    if vim.fn.filereadable(path) == 1 then
      dofile(path)
    end
  end
end

function M.setup(opts)
  M.cfg_dir = opts and opts.cfg_dir or M.cfg_dir
  vim.fn.mkdir(M.cfg_dir, "p")
  M.load_for_cwd()
  vim.api.nvim_create_autocmd("DirChanged", { callback = M.load_for_cwd })
end

return M -- per_dir_cfg.lua
