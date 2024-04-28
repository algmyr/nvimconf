return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function() -- {{{
      require("nvim-treesitter.configs").setup {
        highlight = {
          enable = true,
          disable = {},
          custom_captures = {
            -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
            ["foo.bar"] = "Identifier",
          },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-n>",
            node_incremental = "<C-n>",
            scope_incremental = "<C-s>",
            node_decremental = "<C-p>",
          },
        },
      }
    end, -- }}}
  },
  "nvim-treesitter/playground",
  {
    "mizlan/iswap.nvim",
    event = "VeryLazy",
    opts = { -- {{{
      -- The keys that will be used as a selection, in order
      -- ('asdfghjklqwertyuiopzxcvbnm' by default)
      keys = "1234567890",

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
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
  },
}

-- vim: set fdm=marker:
