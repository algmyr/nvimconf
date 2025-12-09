return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    build = ':TSUpdate',
    config = function() -- {{{
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
          disable = {},
          custom_captures = {
            -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
            ['foo.bar'] = 'Identifier',
          },
        },
        ensure_installed = {
          'vimdoc',
          'luadoc',
          'vim',
          'lua',
          'markdown',
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<C-n>',
            node_incremental = '<C-n>',
            scope_incremental = '<C-s>',
            node_decremental = '<C-p>',
          },
        },
      }
    end, -- }}}
  },
  {
    'mizlan/iswap.nvim',
    event = 'VeryLazy',
    opts = { -- {{{
      -- The keys that will be used as a selection, in order
      -- ('asdfghjklqwertyuiopzxcvbnm' by default)
      keys = '1234567890',

      -- Post-operation flashing highlight style,
      -- either 'simultaneous' or 'sequential', or false to disable
      -- default 'sequential'
      flash_style = false,

      -- Move cursor to the other element in ISwap*With commands
      -- default false
      move_cursor = true,

      -- Automatically swap with only two arguments
      -- default nil
      autoswap = true,
    }, -- }}}
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'VeryLazy',
    config = function()
      require('treesitter-context').setup {
        max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 5, -- Maximum number of lines to show for a single context
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
      }
    end,
  },
}

-- vim: set fdm=marker:
