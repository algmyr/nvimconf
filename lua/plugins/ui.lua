local m = require 'mapping'

return {
  {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cond = not vim.g.started_by_firenvim,
    config = function() -- {{{
      require 'mapping'
      local bufferline = require 'bufferline'

      bufferline.setup {
        options = {
          style_preset = bufferline.style_preset.no_italic,
          diagnostics = 'nvim_lsp',
          separator_style = 'slant',
          show_buffer_close_icons = false,
        },
      }

      m.mappings 'bufferline' {
        ['<leader>'] = {
          n = m.normal { '<cmd>BufferLineCyclePrev<cr>', 'Go to buffer left' },
          m = m.normal { '<cmd>BufferLineCycleNext<cr>', 'Go to buffer right' },
          N = m.normal { '<cmd>BufferLineMovePrev<cr>', 'Move buffer left' },
          M = m.normal { '<cmd>BufferLineMoveNext<cr>', 'Move buffer right' },
        },
      }
    end, -- }}}
  },
  {
    'luukvbaal/statuscol.nvim',
    config = function() require('statuscol').setup() end,
  },
  {
    'nvim-lualine/lualine.nvim',
    cond = not vim.g.started_by_firenvim,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      -- {{{
      local noice = require 'noice'

      local normal = '#cae682'
      local insert = '#fde76e'
      local visual = '#b5d3f3'
      local replace = '#e5786d'
      local command = normal

      local inactive_bg = '#32322f'
      local main_bg = '#242424'

      local function gen_theme(accent, bg)
        local black = '#141413'
        local light_bg = '#32322f'
        return {
          a = { bg = accent, fg = black, gui = 'bold' },
          b = { bg = light_bg, fg = accent },
          c = { bg = bg, fg = accent },
        }
      end

      local custom_wombat = require 'lualine.themes.wombat'
      custom_wombat.normal = gen_theme(normal, main_bg)
      custom_wombat.insert = gen_theme(insert, main_bg)
      custom_wombat.visual = gen_theme(visual, main_bg)
      custom_wombat.replace = gen_theme(replace, main_bg)
      custom_wombat.command = gen_theme(command, main_bg)
      custom_wombat.inactive = gen_theme(nil, inactive_bg)
      -- }}}

      require('lualine').setup {
        options = {
          theme = custom_wombat,
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            'branch',
            {
              'diff',
              source = function() return vim.b.vcsigns_stats end,
            },
            'diagnostics',
          },
          lualine_c = { 'filename' },
          lualine_x = {
            {
              noice.api.status.mode.get,
              cond = noice.api.status.mode.has,
              color = { fg = '#ff9e64' },
            },
            {
              noice.api.status.search.get,
              cond = noice.api.status.search.has,
              color = { fg = '#ff9e64' },
            },
            {
              'selectioncount',
              color = { fg = '#ff9e64' },
            },
            'encoding',
            'fileformat',
            'filetype',
          },
          lualine_y = {
            'progress',
          },
          lualine_z = {
            'location',
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }
    end,
  },
  {
    'smjonas/inc-rename.nvim',
    config = function()
      require('inc_rename').setup()
      vim.lsp.buf.rename = function() vim.api.nvim_feedkeys(':IncRename ' .. vim.fn.expand '<cword>', 'n', false) end
    end,
  },
  {
    'folke/noice.nvim',
    config = function()
      require('noice').setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            -- ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            -- ['vim.lsp.util.stylize_markdown'] = true,
            -- override the default lsp markdown formatter with Noice
            ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
            -- override the lsp markdown formatter with Noice
            ["vim.lsp.util.stylize_markdown"] = false,
            -- override cmp documentation with Noice (needs the other options to work)
            ["cmp.entry.get_documentation"] = false,
          },
          signature = { enabled = false },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup {
        top_down = false,
        stages = 'static',
        render = 'compact',
      }
    end,
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function() require('ibl').setup {} end,
  },
}

-- vim: set fdm=marker:
