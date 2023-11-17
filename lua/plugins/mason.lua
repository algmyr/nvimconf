require "mapping"

return {
  { "williamboman/mason.nvim", opts = {} },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "simrat39/rust-tools.nvim",
      "williamboman/mason.nvim",
      "SmiteshP/nvim-navic",
      "ray-x/lsp_signature.nvim",
    },
    config = function() -- {{{
      local config = require("config.lsp_defaults").get_default_config()

      -- Auto setup
      local mason_lspconfig = require "mason-lspconfig"
      mason_lspconfig.setup()
      mason_lspconfig.setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup(config)
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        ["rust_analyzer"] = function()
          require("rust-tools").setup {
            server = {
              on_attach = config.on_attach,
            },
            tools = { -- rust-tools options
              -- These apply to the default RustSetInlayHints command
              inlay_hints = {
                auto = false,
                --only_current_line = false,
                --show_parameter_hints = true,
                parameter_hints_prefix = "← ",
                other_hints_prefix = "→ ",
                highlight = "Annotation",
              },
            },
          }
        end,
        ["clangd"] = function()
          local capabilities =
            vim.tbl_extend("force", {}, config.capabilities) -- silly
          capabilities.offsetEncoding = { "utf-16" }
          require("lspconfig").clangd.setup {
            capabilities = capabilities,
            cmd = {
              "clangd",
              "--background-index",
              "--clang-tidy",
              "--completion-style=bundled",
              "--header-insertion=iwyu",
              "--pch-storage=memory",
              "--inlay-hints=true",
            },
          }
        end,
      }
    end, -- }}}
  },
}

-- vim: set fdm=marker:
