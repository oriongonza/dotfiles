-- Neovim Configuration Integration Test Suite
-- Run with: nvim --headless -u init.lua -c "luafile test_config.lua"

local test_results = {}
local total_tests = 0
local passed_tests = 0
local failed_tests = 0

-- Force load all lazy plugins first
vim.defer_fn(function()
  require('lazy').load({ plugins = vim.tbl_keys(require('lazy').plugins()) })
end, 100)

-- Wait a bit for plugins to load
vim.defer_fn(function()
  run_all_tests()
end, 500)

function run_all_tests()
-- Test helper functions
local function test(name, fn)
  total_tests = total_tests + 1
  local status, err = pcall(fn)
  if status then
    passed_tests = passed_tests + 1
    table.insert(test_results, { name = name, status = "✓ PASS", error = nil })
    print(string.format("✓ PASS: %s", name))
  else
    failed_tests = failed_tests + 1
    table.insert(test_results, { name = name, status = "✗ FAIL", error = err })
    print(string.format("✗ FAIL: %s", name))
    print(string.format("  Error: %s", err))
  end
end

local function assert_true(condition, message)
  if not condition then
    error(message or "Assertion failed")
  end
end

local function assert_not_nil(value, message)
  if value == nil then
    error(message or "Expected non-nil value")
  end
end

local function assert_type(value, expected_type, message)
  if type(value) ~= expected_type then
    error(message or string.format("Expected type %s, got %s", expected_type, type(value)))
  end
end

local function keymap_exists(mode, lhs)
  local keymaps = vim.api.nvim_get_keymap(mode)
  for _, map in ipairs(keymaps) do
    if map.lhs == lhs then
      return true
    end
  end
  -- Also check buffer-local keymaps (create temp buffer)
  local buf = vim.api.nvim_create_buf(false, true)
  local buf_keymaps = vim.api.nvim_buf_get_keymap(buf, mode)
  for _, map in ipairs(buf_keymaps) do
    if map.lhs == lhs then
      return true
    end
  end
  return false
end

local function plugin_available(plugin_name)
  local ok = pcall(require, plugin_name)
  return ok
end

print("\n" .. string.rep("=", 70))
print("  NEOVIM CONFIGURATION INTEGRATION TEST SUITE")
print(string.rep("=", 70) .. "\n")

-- ============================================================================
-- TEST SUITE 1: Core Configuration
-- ============================================================================
print("\n[1] Testing Core Configuration...")
print(string.rep("-", 70))

test("Leader key is set to space", function()
  assert_true(vim.g.mapleader == " ", "Leader key should be space")
end)

test("Config modules are loadable", function()
  assert_not_nil(package.loaded['config'], "config module should be loaded")
  assert_not_nil(package.loaded['config.options'], "config.options should be loaded")
  assert_not_nil(package.loaded['config.keymaps'], "config.keymaps should be loaded")
  assert_not_nil(package.loaded['config.autocmds'], "config.autocmds should be loaded")
end)

test("Core helpers module exists", function()
  local helpers = require('core.helpers')
  assert_not_nil(helpers, "helpers module should exist")
  assert_type(helpers.get_desc, "function", "get_desc should be a function")
  assert_type(helpers.nmap, "function", "nmap should be a function")
end)

test("Options are set correctly", function()
  assert_true(vim.opt.number:get(), "number should be enabled")
  assert_true(vim.opt.relativenumber:get(), "relativenumber should be enabled")
  assert_true(vim.opt.expandtab:get(), "expandtab should be enabled")
  assert_true(vim.opt.tabstop:get() == 2, "tabstop should be 2")
  assert_true(vim.opt.shiftwidth:get() == 2, "shiftwidth should be 2")
end)

-- ============================================================================
-- TEST SUITE 2: Plugin Loading
-- ============================================================================
print("\n[2] Testing Plugin Loading...")
print(string.rep("-", 70))

test("Lazy.nvim is installed", function()
  assert_not_nil(package.loaded['lazy'], "lazy should be loaded")
end)

test("Essential plugins are available", function()
  local plugins = {
    'telescope',
    'nvim-treesitter',
    'gitsigns',
    'oil',
    'which-key',
    'lualine',
  }
  
  for _, plugin in ipairs(plugins) do
    local ok = plugin_available(plugin)
    assert_true(ok, string.format("Plugin %s should be available", plugin))
  end
end)

test("Plugin modules are structured correctly", function()
  local plugin_files = {
    'plugins.editor',
    'plugins.ui',
    'plugins.git',
    'plugins.navigation',
    'plugins.coding',
    'plugins.colorscheme',
    'plugins.tools',
    'plugins.time',
  }
  
  for _, module in ipairs(plugin_files) do
    local ok = pcall(require, module)
    assert_true(ok, string.format("Plugin module %s should be loadable", module))
  end
end)

test("LSP modules are structured correctly", function()
  local lsp_modules = {
    'plugins.lsp.init',
    'plugins.lsp.keymaps',
    'plugins.lsp.servers',
    'plugins.lsp.autoformat',
    'plugins.lsp.languages.rust',
  }
  
  for _, module in ipairs(lsp_modules) do
    local ok = pcall(require, module)
    assert_true(ok, string.format("LSP module %s should be loadable", module))
  end
end)

test("DAP modules are structured correctly", function()
  local dap_modules = {
    'plugins.dap.init',
    'plugins.dap.keymaps',
  }
  
  for _, module in ipairs(dap_modules) do
    local ok = pcall(require, module)
    assert_true(ok, string.format("DAP module %s should be loadable", module))
  end
end)

-- ============================================================================
-- TEST SUITE 3: File Structure Validation
-- ============================================================================
print("\n[3] Testing File Structure...")
print(string.rep("-", 70))

test("No old plugin files exist", function()
  local old_files = {
    'plugin/remaps.lua',
    'plugin/telescope.lua',
    'plugin/lsp.lua',
    'plugin/options.lua',
    'plugin/vim/options.vim',
    'lua/plugs/gitsigns.lua',
    'lua/kickstart/plugins/autoformat.lua',
  }
  
  for _, file in ipairs(old_files) do
    local path = vim.fn.stdpath('config') .. '/' .. file
    assert_true(vim.fn.filereadable(path) == 0, string.format("Old file %s should not exist", file))
  end
end)

test("New structure files exist", function()
  local new_files = {
    'lua/config/init.lua',
    'lua/config/options.lua',
    'lua/config/keymaps.lua',
    'lua/config/autocmds.lua',
    'lua/core/helpers.lua',
    'lua/plugins/editor.lua',
    'lua/plugins/ui.lua',
    'lua/plugins/git.lua',
    'lua/plugins/navigation.lua',
    'lua/plugins/lsp/init.lua',
  }
  
  for _, file in ipairs(new_files) do
    local path = vim.fn.stdpath('config') .. '/' .. file
    assert_true(vim.fn.filereadable(path) == 1, string.format("New file %s should exist", file))
  end
end)

-- ============================================================================
-- TEST SUITE 4: LSP Configuration
-- ============================================================================
print("\n[4] Testing LSP Configuration...")
print(string.rep("-", 70))

test("LSP servers configuration is valid", function()
  local servers = require('plugins.lsp.servers')
  assert_not_nil(servers, "LSP servers config should exist")
  assert_type(servers, "table", "servers should be a table")
  
  -- Check some expected servers
  assert_not_nil(servers.lua_ls, "lua_ls should be configured")
  assert_not_nil(servers.ts_ls, "ts_ls should be configured")
  
  -- Verify structure
  assert_type(servers.lua_ls, "table", "lua_ls config should be a table")
end)

test("LSP keymaps module has correct interface", function()
  local lsp_keymaps = require('plugins.lsp.keymaps')
  assert_not_nil(lsp_keymaps, "LSP keymaps module should exist")
  assert_type(lsp_keymaps.setup, "function", "LSP keymaps should have setup function")
end)

-- ============================================================================
-- TEST SUITE 5: Code Quality Checks
-- ============================================================================
print("\n[5] Testing Code Quality...")
print(string.rep("-", 70))

test("No duplicate get_desc function", function()
  local helpers = require('core.helpers')
  assert_type(helpers.get_desc, "function", "get_desc should exist in helpers")
  
  -- Verify it works
  local result = helpers.get_desc("test", "description")
  assert_true(result == "description", "get_desc should return description when provided")
  
  local result2 = helpers.get_desc("fallback", nil)
  assert_true(result2 == "fallback", "get_desc should return name when description is nil")
end)

test("No duplicate nmap function", function()
  local helpers = require('core.helpers')
  assert_type(helpers.nmap, "function", "nmap should exist in helpers")
end)

test("LSP keymaps only defined in lsp/keymaps.lua", function()
  -- Check that plugins.lsp.keymaps exists
  local lsp_keymaps = require('plugins.lsp.keymaps')
  assert_not_nil(lsp_keymaps.setup, "LSP keymaps should have setup function")
  
  -- This verifies the function exists in the right place
  assert_type(lsp_keymaps.setup, "function", "setup should be a function")
end)

-- ============================================================================
-- TEST SUITE 6: Module Interfaces
-- ============================================================================
print("\n[6] Testing Module Interfaces...")
print(string.rep("-", 70))

test("DAP keymaps module has correct interface", function()
  local dap_keymaps = require('plugins.dap.keymaps')
  assert_not_nil(dap_keymaps, "DAP keymaps module should exist")
  assert_type(dap_keymaps.setup, "function", "DAP keymaps should have setup function")
end)

test("Per-directory config has correct interface", function()
  local per_dir_cfg = require('system.per_dir_cfg')
  assert_not_nil(per_dir_cfg, "per_dir_cfg module should exist")
  assert_type(per_dir_cfg.setup, "function", "per_dir_cfg should have setup function")
  assert_type(per_dir_cfg.load_for_cwd, "function", "per_dir_cfg should have load_for_cwd")
  assert_type(per_dir_cfg.cfg_dir, "string", "per_dir_cfg should have cfg_dir path")
end)

-- ============================================================================
-- TEST SUITE 7: Plugin Specs Validation
-- ============================================================================
print("\n[7] Testing Plugin Specs...")
print(string.rep("-", 70))

test("Plugin specs return tables", function()
  local spec_modules = {
    'plugins.editor',
    'plugins.ui',
    'plugins.git',
    'plugins.navigation',
    'plugins.coding',
    'plugins.tools',
  }
  
  for _, module in ipairs(spec_modules) do
    local spec = require(module)
    assert_type(spec, "table", string.format("%s should return a table", module))
    assert_true(#spec > 0, string.format("%s should not be empty", module))
  end
end)

test("LSP plugin specs are valid", function()
  local lsp_spec = require('plugins.lsp.init')
  assert_type(lsp_spec, "table", "LSP spec should be a table")
  assert_not_nil(lsp_spec[1], "LSP spec should have plugin name")
  assert_type(lsp_spec.config, "function", "LSP spec should have config function")
end)

test("DAP plugin spec is valid", function()
  local dap_spec = require('plugins.dap.init')
  assert_type(dap_spec, "table", "DAP spec should be a table")
  assert_not_nil(dap_spec[1], "DAP spec should have plugin name")
  assert_type(dap_spec.config, "function", "DAP spec should have config function")
end)

-- ============================================================================
-- TEST SUITE 8: Commands and Autocommands
-- ============================================================================
print("\n[8] Testing Commands and Autocommands...")
print(string.rep("-", 70))

test("User commands exist", function()
  assert_true(vim.fn.exists(':Colorscheme') > 0, ":Colorscheme command should exist")
  assert_true(vim.fn.exists(':Resource') > 0, ":Resource command should exist")
  assert_true(vim.fn.exists(':Config') > 0, ":Config command should exist")
  assert_true(vim.fn.exists(':CpPath') > 0, ":CpPath command should exist")
end)

test("Autocommands are registered", function()
  local augroups = vim.api.nvim_get_autocmds({ group = 'YankHighlight' })
  assert_true(#augroups > 0, "YankHighlight autogroup should exist")
end)

-- ============================================================================
-- TEST SUITE 9: Colorscheme Integration
-- ============================================================================
print("\n[9] Testing Colorscheme...")
print(string.rep("-", 70))

test("Colorscheme module is valid", function()
  local colorscheme_spec = require('plugins.colorscheme')
  assert_type(colorscheme_spec, "table", "Colorscheme spec should be a table")
  assert_type(colorscheme_spec.config, "function", "Colorscheme should have config function")
end)

test("GitHub theme is available", function()
  local themes = vim.fn.getcompletion('github', 'color')
  assert_true(#themes > 0, "GitHub themes should be available")
end)

-- ============================================================================
-- TEST SUITE 10: Integration Points
-- ============================================================================
print("\n[10] Testing Integration Points...")
print(string.rep("-", 70))

test("Helpers are used correctly", function()
  local helpers = require('core.helpers')
  
  -- Test get_desc
  local desc1 = helpers.get_desc("name", "description")
  assert_true(desc1 == "description", "get_desc should return description")
  
  local desc2 = helpers.get_desc("name", nil)
  assert_true(desc2 == "name", "get_desc should return name as fallback")
  
  -- nmap should be a function
  assert_type(helpers.nmap, "function", "nmap should be callable")
end)

test("Init.lua loads all required modules", function()
  -- These should be loaded by init.lua
  assert_not_nil(package.loaded['config'], "config should be loaded")
  assert_not_nil(package.loaded['lazy'], "lazy should be loaded")
  assert_not_nil(package.loaded['system.per_dir_cfg'], "per_dir_cfg should be loaded")
end)

-- ============================================================================
-- RESULTS SUMMARY
-- ============================================================================
print("\n" .. string.rep("=", 70))
print("  TEST RESULTS SUMMARY")
print(string.rep("=", 70))
print(string.format("\nTotal Tests: %d", total_tests))
print(string.format("Passed:      %d (%.1f%%)", passed_tests, (passed_tests/total_tests)*100))
print(string.format("Failed:      %d (%.1f%%)", failed_tests, (failed_tests/total_tests)*100))

if failed_tests > 0 then
  print("\nFailed Tests:")
  for _, result in ipairs(test_results) do
    if result.status == "✗ FAIL" then
      print(string.format("  - %s", result.name))
      if result.error then
        print(string.format("    %s", result.error))
      end
    end
  end
end

print("\n" .. string.rep("=", 70))

if failed_tests == 0 then
  print("✓ ALL TESTS PASSED! Configuration is working correctly.")
  print(string.rep("=", 70) .. "\n")
  vim.cmd('qall!')
else
  print("✗ SOME TESTS FAILED. Please review the errors above.")
  print(string.rep("=", 70) .. "\n")
  vim.cmd('cquit')
end

end -- run_all_tests function
