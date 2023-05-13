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
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "SmiteshP/nvim-navic",
    },
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

      local function gen_theme(accent, bg)
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

      local navic = require "nvim-navic"
      require("lualine").setup {
        options = {
          theme = custom_wombat,
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            "filename",
            {
              function()
                return navic.get_location()
              end,
              cond = function()
                return navic.is_available()
              end,
            },
          },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            "filename",
          },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }
    end, -- }}}
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      local navic = require "nvim-navic"
      navic.setup {
        separator = "  ",
      }
    end,
  },
  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
}

-- vim: set fdm=marker:
