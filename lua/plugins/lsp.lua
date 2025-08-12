local m = require 'mapping'

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      m.mappings 'LSP' {
        ['<space>e'] = m.normal { vim.diagnostic.open_float, 'Open diagnostic float' },
        ['[d'] = m.normal {
          function() vim.diagnostic.jump { count = -1, float = true } end,
          'Go to previous diagnostic',
        },
        [']d'] = m.normal { function() vim.diagnostic.jump { count = 1, float = true } end, 'Go to next diagnostic' },
        ['<space>q'] = m.normal { vim.diagnostic.setloclist, 'Add diagnostics to loclist' },
      }
    end,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {},
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
}

-- vim: set fdm=marker:
