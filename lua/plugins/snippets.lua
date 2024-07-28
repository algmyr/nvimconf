local m = require 'mapping'

return {
  'L3MON4D3/LuaSnip',
  version = '1.*',
  build = 'make install_jsregexp',
  dependencies = {
    {
      'rafamadriz/friendly-snippets',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
        require('luasnip.loaders.from_snipmate').lazy_load {
          paths = { './snippets' },
        }

        m.mappings 'luasnip' {
          ['<C-k>'] = {
            insert = {
              "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-k>'",
              'Expand or jump',
              { expr = true, replace_keycodes = false },
            },
            select = { function() require('luasnip').jump(1) end, 'Jump forwards' },
          },
          ['<C-S-k>'] = {
            insert = { function() require('luasnip').jump(-1) end, 'Jump backwards' },
            select = { function() require('luasnip').jump(-1) end, 'Jump backwards' },
          },
          ['<C-E>'] = {
            insert = {
              "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'",
              'Change choice in choiceNodes',
              { expr = true, replace_keycodes = false },
            },
            select = {
              "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'",
              'Change choice in choiceNodes',
              { expr = true, replace_keycodes = false },
            },
          },
        }
      end,
    },
  },
}
