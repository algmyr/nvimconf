return {
  {
    'NvChad/nvim-colorizer.lua',
    opts = {
      filetypes = { '*' },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue or blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        mode = 'background', -- Mode (foreground, background, virtualtext)
        virtualtext = '■',
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {},
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      code = {
        -- Highlight for code blocks.
        highlight = 'String',
        -- Highlight for code info section, after the language.
        highlight_info = '@label',
        -- Highlight for language, overrides icon provider value.
        highlight_language = nil,
        -- Highlight for border, use false to add no highlight.
        highlight_border = '@label',
        -- Highlight for language, used if icon provider does not have a value.
        highlight_fallback = '@label',
        -- Highlight for inline code.
        highlight_inline = 'String',
      },
    },
  },
}
