require "mapping"

local function on_attach(client, bufnr)
  if client.supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint(0, true)
  end

  --require("lsp_signature").on_attach({}, bufnr)
  if client.supports_method("textDocument/documentSymbol") then
    require("nvim-navic").attach(client, bufnr)
  end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_set_option_value(
    "omnifunc",
    "v:lua.vim.lsp.omnifunc",
    { buf = bufnr }
  )

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { buffer = bufnr }
  --nmap("gD", vim.lsp.buf.declaration, bufopts)
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

local function setup_and_get_default_config()
  local config = require("lspconfig").util.default_config
  config.on_attach = on_attach
  config.capabilities = require("cmp_nvim_lsp").default_capabilities()
  config.inlay_hints = { enabled = true }
  return config
end

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
      local config = setup_and_get_default_config()

      -- Auto setup
      local mason_lspconfig = require "mason-lspconfig"
      mason_lspconfig.setup()
      mason_lspconfig.setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            on_attach = config.on_attach,
          }
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
