require "mapping"

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim" },
    config = function() -- {{{
      -- Mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      nmap("<space>e", vim.diagnostic.open_float, "Open diagnostic float (LSP)")
      nmap("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic (LSP)")
      nmap("]d", vim.diagnostic.goto_next, "Go to next diagnostic (LSP)")
      nmap(
        "<space>q",
        vim.diagnostic.setloclist,
        "Add diagnostics to loclist (LSP)"
      )
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
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
      vim.diagnostic.config {
        virtual_lines = {
          only_current_line = true,
        },
      }
    end,
  },
  {
    "dnlhc/glance.nvim",
    config = function()
      local context_len = 15
      require("glance").setup {
        height = 2 * context_len + 1 + 1,
        preview_win_opts = {
          cursorline = true,
          number = true,
          wrap = false,
        },
      }
      nmap("gD", "<CMD>Glance definitions<CR>", "Go to definition (Glance)")
      nmap("gR", "<CMD>Glance references<CR>", "Go to references (Glance)")
      nmap(
        "gY",
        "<CMD>Glance type_definitions<CR>",
        "Go to type definitions (Glance)"
      )
      nmap(
        "gM",
        "<CMD>Glance implementations<CR>",
        "Go to implementations (Glance)"
      )
    end,
  },
}

-- vim: set fdm=marker:
