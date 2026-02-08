-- Git integration plugins
return {
  -- Gitsigns (git decorations and hunk operations)
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local function map(mode, l, r, desc, opts)
          opts = opts or {}
          opts.buffer = bufnr
          opts.desc = desc
          vim.keymap.set(mode, l, r, opts)
        end

        local gs = require("gitsigns")
        map('n', '<leader>GH', gs.prev_hunk, '[G]it go to Previous Hunk')
        map('n', '<leader>Gh', gs.next_hunk, '[G]it go to Next Hunk')
        map('n', '<leader>Gp', gs.preview_hunk, '[G]it [p]review hunk')
        map('n', '<leader>Gsh', gs.stage_hunk, '[G]it [s]tage [h]unk')
        map('n', '<leader>Gsb', gs.stage_buffer, '[G]it [s]tage [b]uffer')
        map('n', '<leader>GSh', gs.undo_stage_hunk, '[G]it un[S]tage [h]unk')
        map('n', '<leader>Grb', gs.reset_buffer, '[G]it [r]eset buffer')
        map('n', '<leader>Grh', gs.reset_hunk, '[G]it [r]eset [h]unk')
        map('n', '<leader>GB', function() gs.blame_line { full = true } end, '[G]it [B]lame this line')
        map('n', '<leader>Gb', gs.toggle_current_line_blame, '[G]it [b]lame toggle')
        map('n', '<leader>Gd', gs.diffthis, '[G]it [d]iff')
        map('n', '<leader>Gdt', function() gs.diffthis('~') end, '[G]it [d]iff [t]his')
        map('n', '<leader>Gg', gs.toggle_deleted, '[G]it [g]one (toggle deleted)')
      end,
    },
  },

  -- Fugitive (git commands)
  'tpope/vim-fugitive',

  -- Rhubarb (GitHub integration)
  'tpope/vim-rhubarb',

  -- Flog (git log viewer)
  {
    "rbong/vim-flog",
    lazy = true,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
      "tpope/vim-fugitive",
    },
  },
}
