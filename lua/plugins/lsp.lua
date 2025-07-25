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
  {
    'felpafel/inlay-hint.nvim',
    event = 'LspAttach',
    config = function()
      require('inlay-hint').setup {
        -- 'eol', 'right_align', 'inline'
        virt_text_pos = 'eol',
        highlight_group = 'LspInlayHint',
        display_callback = function(line_hints, options, bufnr)
          if options.virt_text_pos == 'inline' then
            local lhint = {}
            for _, hint in pairs(line_hints) do
              local text = ''
              local label = hint.label
              if type(label) == 'string' then
                text = label
              else
                for _, part in ipairs(label) do
                  text = text .. part.value
                end
              end
              if hint.paddingLeft then text = ' ' .. text end
              if hint.paddingRight then text = text .. ' ' end
              lhint[#lhint + 1] = { text = text, col = hint.position.character }
            end
            return lhint
          elseif options.virt_text_pos == 'eol' or options.virt_text_pos == 'right_align' then
            local k1 = {}
            local k2 = {}
            table.sort(line_hints, function(a, b) return a.position.character < b.position.character end)
            for _, hint in pairs(line_hints) do
              local label = hint.label
              local kind = hint.kind
              local node = kind == 1
                  and vim.treesitter.get_node {
                    bufnr = bufnr,
                    pos = {
                      hint.position.line,
                      hint.position.character - 1,
                    },
                  }
                or nil
              local node_text = node and vim.treesitter.get_node_text(node, bufnr, {}) or ''
              local text = ''
              if type(label) == 'string' then
                text = label
              else
                for _, part in ipairs(label) do
                  text = text .. part.value
                end
              end
              if kind == 1 then
                k1[#k1 + 1] = text:gsub(':%s*', node_text .. ': ')
              else
                k2[#k2 + 1] = text:gsub(':$', '')
              end
            end
            local text = ''
            if #k2 > 0 then text = '<- (' .. table.concat(k2, ',') .. ')' end
            if #text > 0 then text = text .. ' ' end
            if #k1 > 0 then text = text .. '=> ' .. table.concat(k1, ', ') end

            return text
          end
          return nil
        end,
      }
    end,
  },
}

-- vim: set fdm=marker:
