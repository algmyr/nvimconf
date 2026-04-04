return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = function(ev)
      if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
      vim.cmd 'TSUpdate'
    end,
    config = function()
      local treesitter = require 'nvim-treesitter'
      treesitter.setup()

      local ensure_installed = {
        'vimdoc',
        'luadoc',
        'vim',
        'lua',
        'markdown',
      }

      treesitter.install(ensure_installed):wait()

      local installed = treesitter.get_installed()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = installed,
        callback = function()
          -- syntax highlighting, provided by Neovim
          vim.treesitter.start()
          -- folds, provided by Neovim (I don't like folds)
          -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          -- vim.wo.foldmethod = 'expr'
          -- indentation, provided by nvim-treesitter
          -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
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
