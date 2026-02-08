-- LSP keymaps (unified - no duplication)
local M = {}

function M.setup(bufnr)
  local helpers = require('core.helpers')
  local get_desc = helpers.get_desc
  
  local nmap = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  -- LSP actions
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>r', vim.lsp.buf.rename, '[R]ename')
  nmap('<leader>a', vim.lsp.buf.code_action, '[A]ction')
  vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, { buffer = bufnr, desc = '[A]ction' })
  nmap('<leader>lf', vim.lsp.buf.format, '[L]sp [f]ormat')
  nmap('<leader>lh', vim.lsp.buf.document_highlight, '[L]sp [h]ighlight')
  nmap('<leader>lH', vim.lsp.buf.clear_references, '[L]sp clear [H]ighlight')
  nmap('<leader>lr', ':LspRestart<CR>', '[L]sp [r]eload')
  nmap('<leader>lih', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, '[L]sp toggle [i]nlay [h]ints')

  -- Telescope LSP pickers (UNIFIED HERE - no duplication with telescope.lua)
  local tbi = require('telescope.builtin')
  local function tscope_lsp(key, f, desc)
    nmap('g' .. key, tbi[f], '[G]o to ' .. get_desc(f, desc))
  end

  tscope_lsp('d', "lsp_definitions", '[d]efinition')
  tscope_lsp('i', "lsp_implementations", '[i]mplementation')
  tscope_lsp('t', "lsp_type_definitions", '[t]ype definition')
  tscope_lsp('r', "lsp_references", '[r]eferences')
  tscope_lsp('z', "lsp_incoming_calls", 'incoming calls')
  tscope_lsp('Z', "lsp_outgoing_calls", 'outgoing calls')
  tscope_lsp('s', "lsp_workspace_symbols", 'workspace symbols')
  tscope_lsp('S', "lsp_document_symbols", 'document symbols')
end

return M
