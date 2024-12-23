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
    'folke/neodev.nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function() -- {{{
      require('neodev').setup {
        override = function(root_dir, library)
          if require('neodev.util').has_file(root_dir, '~/.local/share/nvim/lazy') then
            library.enabled = true
            library.plugins = true
          end
        end,
      }

      -- then setup your lsp server as usual
      local lspconfig = require 'lspconfig'

      -- example to setup lua_ls and enable call snippets
      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
      }
    end, -- }}}
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
