return {
  {
    "machakann/vim-highlightedyank",
    event = "VeryLazy",
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue or blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        mode = "background", -- Mode (foreground, background, virtualtext)
        virtualtext = "■",
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {},
    },
  },
  {
    "wookayin/semshi",
    event = "VeryLazy",
    config = function()
      -- Semshi uses FileType autocmds on init. Have it called once again when lazy loaded.
      vim.cmd [[ doautocmd SemshiInit FileType python ]]
    end,
    build = ":UpdateRemotePlugins",
  },
}
