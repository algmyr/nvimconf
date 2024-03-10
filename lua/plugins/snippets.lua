return {
  "L3MON4D3/LuaSnip",
  version = "1.*",
  build = "make install_jsregexp",
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_snipmate").lazy_load {
          paths = { "./snippets" },
        }

        imap(
          "<C-k>",
          "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-k>'",
          "Expand or jump (luasnip)",
          { expr = true, replace_keycodes = false }
        )
        imap("<C-S-k>", function()
          require("luasnip").jump(-1)
        end, "Jump backwards (luasnip)")

        smap("<C-k>", function()
          require("luasnip").jump(1)
        end, "Jump forwards (luasnip)")
        smap("<C-S-k>", function()
          require("luasnip").jump(-1)
        end, "Jump backwards (luasnip)")

        -- For changing choices in choiceNodes (not strictly necessary for a basic setup).
        imap(
          "<C-E>",
          "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'",
          "Change choice in choiceNodes (luasnip)",
          { expr = true, replace_keycodes = false }
        )
        smap(
          "<C-E>",
          "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'",
          "Change choice in choiceNodes (luasnip)",
          { expr = true, replace_keycodes = false }
        )
      end,
    },
  },
}
