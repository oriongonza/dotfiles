# Custom Neovim Features

This document describes all custom features that are **not** plugin configurations. These are custom utilities and enhancements built specifically for this configuration.

All features are located in `lua/features/` and are automatically loaded by `lua/features/init.lua`.

---

## Table of Contents

1. [Time Insertion](#1-time-insertion)
2. [Terminal Tab Management](#2-terminal-tab-management)
3. [Popup Killer](#3-popup-killer)
4. [Custom Commands](#4-custom-commands)
5. [gw Vsplit](#5-gw-vsplit)
6. [Colorscheme Rotation](#6-colorscheme-rotation)
7. [Per-Directory Config](#7-per-directory-config)

---

## 1. Time Insertion

**File:** [`lua/features/time_insertion.lua`](lua/features/time_insertion.lua)

Insert various time and date formats at the cursor position with leader key combinations.

### Keymaps

| Keymap | Format | Description | Example Output |
|--------|--------|-------------|----------------|
| `<leader>tx` | `%Y-%m-%d %H:%M:%S` | Full timestamp | `2026-02-08 04:23:15` |
| `<leader>td` | `%Y-%m-%d` | Date only | `2026-02-08` |
| `<leader>tt` | `%H:%M:%S` | Time only | `04:23:15` |
| `<leader>tw` | `%A` | Weekday name | `Saturday` |
| `<leader>ti` | `%Y%m%d%H%M%S` | Sortable timestamp | `20260208042315` |
| `<leader>tu` | `%s` | Unix epoch | `1738986195` |

### Usage

Position your cursor where you want the timestamp, then press the appropriate keymap. The formatted time/date will be inserted at the cursor position.

### Implementation

Uses Lua's `os.date()` function with various format strings and Neovim's `nvim_put()` API to insert the text.

---

## 2. Terminal Tab Management

**File:** [`lua/features/terminal_tabs.lua`](lua/features/terminal_tabs.lua)

Dedicated terminal tab with Alt+t to quickly toggle between your terminal and working tabs.

### Keymaps

| Mode | Keymap | Description |
|------|--------|-------------|
| Normal | `<M-t>` (Alt+t) | Open terminal in dedicated tab 2 |
| Terminal | `<M-t>` (Alt+t) | Return to previous working tab |

### Behavior

- Terminal always opens in tab 2
- Pressing Alt+t in normal mode:
  - Creates tab 2 if it doesn't exist
  - Switches to tab 2
  - Opens a terminal if none exists in tab 2
  - Remembers your previous tab
- Pressing Alt+t in terminal mode:
  - Returns to the tab you were on before entering terminal

### Use Cases

- Quick terminal access without losing context
- Keep terminal in a dedicated space
- Avoid terminal clutter in your main workflow

### Implementation

Uses Vim global variables to track terminal tab and previous tab, with custom functions to manage tab creation and navigation.

---

## 3. Popup Killer

**File:** [`lua/features/popup_killer.lua`](lua/features/popup_killer.lua)

Single Esc press closes all floating windows and clears search highlighting.

### Keymap

| Keymap | Description |
|--------|-------------|
| `<Esc>` | Close all popups + clear search highlight |

### Behavior

When you press Esc in normal mode:
1. Clears search highlighting (`:nohlsearch`)
2. Closes all floating windows (which-key, LSP hover, completions, etc.)

### Why This Exists

By default, Esc only clears search highlighting. This feature extends it to also close floating windows, providing a single "clean up UI" action.

### Use Cases

- Close LSP hover documentation
- Close which-key hints
- Close completion menus
- Clear search highlighting
- All with a single Esc press

### Implementation

Filters all windows in current tabpage for those with `zindex` (floating), then closes them using `nvim_win_close()`.

---

## 4. Custom Commands

**File:** [`lua/features/custom_commands.lua`](lua/features/custom_commands.lua)

Utility commands for config management and workflow.

### Commands

| Command | Description | Usage |
|---------|-------------|-------|
| `:Resource` | Reload Neovim configuration | `:Resource` |
| `:Config` | Edit Neovim configuration (init.lua) | `:Config` |
| `:CpPath` | Copy current file path to clipboard | `:CpPath` |

### Details

#### `:Resource`
- Reloads your `init.lua` without restarting Neovim
- Useful for testing config changes
- Equivalent to `:luafile $MYVIMRC`

#### `:Config`
- Opens `init.lua` for editing
- Quick way to access your config
- Equivalent to `:e $MYVIMRC`

#### `:CpPath`
- Copies the current file's path to system clipboard
- Useful for sharing file locations
- Shows confirmation message with the copied path

### Use Cases

- Quick config editing and reloading
- Share file paths with teammates
- Fast workflow navigation

### Implementation

Uses `nvim_create_user_command()` to register custom commands.

---

## 5. gw Vsplit

**File:** [`lua/features/gw_vsplit.lua`](lua/features/gw_vsplit.lua)

Execute any `g` command (like `gd`, `gf`, `gi`) in a new vertical split.

### Keymap

| Keymap | Description |
|--------|-------------|
| `gw` | Open a vsplit and wait for a `g` command |

### Behavior

Press `gw` followed by any `g` command:
- `gw` + `d` → Go to definition in new vsplit
- `gw` + `f` → Go to file in new vsplit  
- `gw` + `i` → Go to implementation in new vsplit
- etc.

### Why This Exists

Neovim's `g` commands (go to definition, go to file, etc.) open in the current window. Sometimes you want to keep your current view and open the target in a split.

### Use Cases

- Check definition without losing current context
- Compare current file with definition side-by-side
- Browse code in split view workflow

### Implementation

Uses `nvim_feedkeys()` to:
1. Send `<C-w><C-v>` (create vsplit)
2. Send `g` and wait for user to complete the command

---

## 6. Colorscheme Rotation

**File:** [`lua/features/colorscheme_rotation.lua`](lua/features/colorscheme_rotation.lua)

Rotate between three themes (default, dark, light) with a single command.

### Command

| Command | Argument | Description |
|---------|----------|-------------|
| `:Colorscheme` | (none) | Cycle to next theme |
| `:Colorscheme` | `default` | Set default theme |
| `:Colorscheme` | `dark` | Set GitHub dark theme |
| `:Colorscheme` | `light` | Set GitHub light high contrast theme |

### Themes

1. **Default** - System default with custom highlight adjustments
2. **Dark** - `github_dark` colorscheme
3. **Light** - `github_light_high_contrast` colorscheme

### Rotation Order

default → dark → light → default → ...

### Use Cases

- Quick theme switching based on lighting conditions
- Testing colorscheme compatibility
- Preference-based workflow (coding at night vs day)

### Configuration

Initial theme is set to **dark** on startup. You can change this in the plugin spec:

**File:** [`lua/plugins/colorscheme.lua`](lua/plugins/colorscheme.lua)

### Implementation

Maintains a `next_theme` variable that tracks rotation state. Each theme function sets the colorscheme and updates `next_theme` for the next cycle.

---

## 7. Per-Directory Config

**File:** [`lua/system/per_dir_cfg.lua`](lua/system/per_dir_cfg.lua)

Automatically load project-specific configuration based on directory path components.

### How It Works

For a working directory `/home/user/repos/myproject/src`:
1. Checks for `/home/user/.config/nvim/per_project/home.lua` → loads if exists
2. Checks for `/home/user/.config/nvim/per_project/user.lua` → loads if exists
3. Checks for `/home/user/.config/nvim/per_project/repos.lua` → loads if exists
4. Checks for `/home/user/.config/nvim/per_project/myproject.lua` → loads if exists
5. Checks for `/home/user/.config/nvim/per_project/src.lua` → loads if exists

### Directory Structure

```
~/.config/nvim/
└── per_project/
    ├── work.lua          # Loaded when cwd contains "/work/"
    ├── myproject.lua     # Loaded when cwd contains "/myproject/"
    └── thinking.lua      # Your existing thinking.lua
```

### Example Config

**`per_project/myproject.lua`:**
```lua
-- Project-specific settings for myproject
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Project-specific keymap
vim.keymap.set('n', '<leader>pb', ':!./build.sh<CR>')

print("Loaded myproject config")
```

### Use Cases

- Different indentation rules per project
- Project-specific build commands
- Custom keymaps for specific codebases
- Per-client configurations (if you have `/work/clientA/`)

### Automatic Loading

Configs are loaded:
- On Neovim startup for current directory
- On directory change (`:cd`, `:lcd`, etc.)

### Caching

Each directory is only loaded once per session (uses a `loaded` table to track).

### Implementation

Uses `DirChanged` autocmd to trigger config loading, splits path by `/`, and checks for corresponding `.lua` files in `per_project/` directory.

---

## Architecture

All features are:
- **Modular** - Each feature in its own file
- **Optional** - Can be disabled by commenting out in `features/init.lua`
- **Documented** - This file provides comprehensive docs
- **Independent** - Features don't depend on each other

### Loading Order

1. Core config (`lua/config/`)
2. Plugins (`lua/plugins/`) via lazy.nvim
3. **Features** (`lua/features/`) ← You are here
4. Snippets
5. Per-directory configs (`lua/system/per_dir_cfg.lua`)

### Directory Structure

```
lua/
├── features/
│   ├── init.lua                 # Loader (calls .setup() on all features)
│   ├── time_insertion.lua
│   ├── terminal_tabs.lua
│   ├── popup_killer.lua
│   ├── custom_commands.lua
│   ├── gw_vsplit.lua
│   └── colorscheme_rotation.lua
└── system/
    └── per_dir_cfg.lua          # Technically a feature, historically in system/
```

---

## Customization

To disable a feature, comment it out in `lua/features/init.lua`:

```lua
-- Features Module Loader
require('features.time_insertion').setup()
require('features.terminal_tabs').setup()
-- require('features.popup_killer').setup()  -- Disabled
require('features.custom_commands').setup()
require('features.gw_vsplit').setup()
require('features.colorscheme_rotation').setup()
```

To modify a feature, edit its file directly. Each feature is self-contained with a `.setup()` function.

---

## Contributing

When adding a new feature:

1. Create `lua/features/your_feature.lua`
2. Export a `.setup()` function:
   ```lua
   local M = {}
   
   function M.setup()
     -- Your feature implementation
   end
   
   return M
   ```
3. Add to `lua/features/init.lua`:
   ```lua
   require('features.your_feature').setup()
   ```
4. Document it in this file (FEATURES.md)

---

**Last Updated:** 2026-02-08
