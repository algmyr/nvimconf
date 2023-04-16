require "mapping"

return {
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cond = not vim.g.started_by_firenvim,
    config = function() -- {{{
      require "mapping"

      require("bufferline").setup {
        options = {
          diagnostics = "coc",
          separator_style = "slant",
        },
      }

      nmap("<leader>n", ":BufferLineCyclePrev<cr>")
      nmap("<leader>m", ":BufferLineCycleNext<cr>")
      nmap("<leader>N", ":BufferLineMovePrev<cr>")
      nmap("<leader>M", ":BufferLineMoveNext<cr>")
    end, -- }}}
  },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      require("statuscol").setup()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    cond = not vim.g.started_by_firenvim,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() -- {{{
      local custom_wombat = require "lualine.themes.wombat"

      local normal = "#cae682"
      local insert = "#fde76e"
      local visual = "#b5d3f3"
      local replace = "#e5786d"
      local command = normal

      --local inactive_bg = '#1c1c1c'
      local inactive_bg = "#32322f"
      local main_bg = "#242424"

      function gen_theme(accent, bg)
        local black = "#141413"
        local light_bg = "#32322f"
        --local norm_text = '#E3E0D7'
        return {
          a = { bg = accent, fg = black, gui = "bold" },
          b = { bg = light_bg, fg = accent },
          c = { bg = bg, fg = accent },
        }
      end

      custom_wombat.normal = gen_theme(normal, main_bg)
      custom_wombat.insert = gen_theme(insert, main_bg)
      custom_wombat.visual = gen_theme(visual, main_bg)
      custom_wombat.replace = gen_theme(replace, main_bg)
      custom_wombat.command = gen_theme(command, main_bg)
      custom_wombat.inactive = gen_theme(nil, inactive_bg)

      require("lualine").setup {
        options = {
          theme = custom_wombat,
          section_separators = { left = "", right = "" },
          --section_separators = { left = '▌', right = '▐' },
          component_separators = { left = "", right = "" },
        },
      }
    end, -- }}}
  },
}

-- vim: set fdm=marker:
