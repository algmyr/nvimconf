require "mapping"

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim" },
    config = function() -- {{{
      -- Mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      nmap("<space>e", vim.diagnostic.open_float)
      nmap("[d", vim.diagnostic.goto_prev)
      nmap("]d", vim.diagnostic.goto_next)
      nmap("<space>q", vim.diagnostic.setloclist)
    end, -- }}}
  },
  {
    "folke/neodev.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function() -- {{{
      require("neodev").setup {
        override = function(root_dir, library)
          if
            require("neodev.util").has_file(
              root_dir,
              "~/.local/share/nvim/lazy"
            )
          then
            library.enabled = true
            library.plugins = true
          end
        end,
      }

      -- then setup your lsp server as usual
      local lspconfig = require "lspconfig"

      -- example to setup lua_ls and enable call snippets
      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      }
    end, -- }}}
  },
  "ray-x/lsp_signature.nvim",
  {
    "kosayoda/nvim-lightbulb",
    opts = { autocmd = { enabled = true } },
  },
  {
    "weilbith/nvim-code-action-menu",
    config = function() -- {{{
      --nmap("<space>a", ":CodeActionMenu<cr>")
      --vmap("<space>a", ":CodeActionMenu<cr>")
      nmap("<space>a", vim.lsp.buf.code_action)
      vmap("<space>a", vim.lsp.buf.code_action)
    end, -- }}}
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = true,
  },
  {
    "dnlhc/glance.nvim",
    config = function()
      local context_len = 15;
      require('glance').setup({
        height = 2*context_len + 1 + 1,
        preview_win_opts = {
          cursorline = true,
          number = true,
          wrap = false,
        }
      })
      nmap('gD', '<CMD>Glance definitions<CR>')
      nmap('gR', '<CMD>Glance references<CR>')
      nmap('gY', '<CMD>Glance type_definitions<CR>')
      nmap('gM', '<CMD>Glance implementations<CR>')
    end,
  },
}

-- vim: set fdm=marker:
