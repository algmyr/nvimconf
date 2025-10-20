require 'mapping'

return {
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    -- dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'enter',

        ['<tab>'] = { 'select_next', 'fallback' },
        ['<S-tab>'] = { 'select_prev', 'fallback' },
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = {
        documentation = { auto_show = true },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      cmdline = {
        keymap = {
          ['/'] = {
            function(cmp)
              -- Accept directory path completions on '/'.
              local item = cmp.get_selected_item()
              if item and item.label:sub(-1) == '/' then
                cmp.select_and_accept()
                return cmp.show()
              end
            end,
            'fallback',
          },
        },
        completion = { menu = { auto_show = true } },
      },

      signature = {
        enabled = true,
        window = {
          show_documentation = true,
        },
      },

      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
}

-- vim: set fdm=marker:
