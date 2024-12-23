local m = require 'mapping'

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      m.mappings 'LSP' {
        ['<space>e'] = m.normal { vim.diagnostic.open_float, 'Open diagnostic float' },
        ['[d'] = m.normal { vim.diagnostic.goto_prev, 'Go to previous diagnostic' },
        [']d'] = m.normal { vim.diagnostic.goto_next, 'Go to next diagnostic' },
        ['<space>q'] = m.normal { vim.diagnostic.setloclist, 'Add diagnostics to loclist' },
      }
    end,
  },
  {
    'folke/lazydev.nvim',
    ft = "lua",
    opts = {},
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  {
    'dnlhc/glance.nvim',
    config = function()
      local context_len = 15
      require('glance').setup {
        height = 2 * context_len + 1 + 1,
        preview_win_opts = {
          cursorline = true,
          number = true,
          wrap = false,
        },
      }
      m.mappings 'Glance' {
        dD = m.normal { '<cmd>Glance definition<cr>', 'Go to definition' },
        dR = m.normal { '<cmd>Glance references<cr>', 'Go to references' },
        dY = m.normal { '<cmd>Glance type_definitions<cr>', 'Go to type definitions' },
        dM = m.normal { '<cmd>Glance implementations<cr>', 'Go to implementations' },
      }
    end,
  },
}

-- vim: set fdm=marker:
