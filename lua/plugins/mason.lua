require "mapping"

return {
  { "williamboman/mason.nvim", opts = {} },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "simrat39/rust-tools.nvim",
      "williamboman/mason.nvim",
      "ray-x/lsp_signature.nvim",
    },
    config = function() -- {{{
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup()
      local lspconfig = require("lspconfig")
      local lsp_defaults = lspconfig.util.default_config

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      lsp_defaults.on_attach = function(_, bufnr)
        require("lsp_signature").on_attach({}, bufnr)

        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { buffer = bufnr }
        nmap("gD", vim.lsp.buf.declaration, bufopts)
        nmap("gd", vim.lsp.buf.definition, bufopts)
        nmap("K", vim.lsp.buf.hover, bufopts)
        nmap("gi", vim.lsp.buf.implementation, bufopts)
        nmap("<C-k>", vim.lsp.buf.signature_help, bufopts)
        nmap("<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
        nmap("<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
        nmap("<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        nmap("<space>D", vim.lsp.buf.type_definition, bufopts)
        nmap("<space>rn", vim.lsp.buf.rename, bufopts)
        nmap("<space>a", vim.lsp.buf.code_action, bufopts)
        vmap("<space>a", vim.lsp.buf.code_action, bufopts)
        nmap("gr", vim.lsp.buf.references, bufopts)
        nmap("<space>f", function()
          vim.lsp.buf.format { async = true }
        end, bufopts)
      end

      lsp_defaults.capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Auto setup
      mason_lspconfig.setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            on_attach = lsp_defaults.on_attach,
          }
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        ["rust_analyzer"] = function()
          require("rust-tools").setup {
            server = {
              on_attach = lsp_defaults.on_attach,
            },
            tools = { -- rust-tools options
              -- These apply to the default RustSetInlayHints command
              inlay_hints = {
                --only_current_line = false,
                --show_parameter_hints = true,
                parameter_hints_prefix = "← ",
                other_hints_prefix = "→ ",
                highlight = "Annotation",
              },
            },
          }
        end,
      }
    end, -- }}}
  },
}

-- vim: set fdm=marker:
