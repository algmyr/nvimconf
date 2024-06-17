local M = {}

local function on_attach(client, bufnr)
  if client.supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, {bufnr=0})
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
  nmap("gd", vim.lsp.buf.definition, 'Go to definition (LSP)', bufopts)
  nmap("K", vim.lsp.buf.hover, 'Hover (LSP)', bufopts)
  nmap("gi", vim.lsp.buf.implementation, 'Go to implementation (LSP)', bufopts)
  nmap("<C-k>", vim.lsp.buf.signature_help, 'Signature help (LSP)', bufopts)
  nmap("<space>wa", vim.lsp.buf.add_workspace_folder, 'Add workspace folder (LSP)', bufopts)
  nmap("<space>wr", vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder (LSP)', bufopts)
  nmap("<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, 'List workspace folders (LSP)', bufopts)
  nmap("<space>D", vim.lsp.buf.type_definition, 'Go to type definition (LSP)', bufopts)
  nmap("<space>rn", vim.lsp.buf.rename, 'Rename (LSP)', bufopts)
  nmap("<space>a", vim.lsp.buf.code_action, 'Code action (LSP)', bufopts)
  vmap("<space>a", vim.lsp.buf.code_action, 'Code action (LSP)', bufopts)
  nmap("gr", vim.lsp.buf.references, 'Go to references (LSP)', bufopts)
  nmap("<space>F", function()
    vim.lsp.buf.format { async = true }
  end, 'Format (LSP)', bufopts)
end

function M.get_default_config()
  local config = require("lspconfig").util.default_config
  config.on_attach = on_attach
  config.capabilities = require("cmp_nvim_lsp").default_capabilities()
  config.inlay_hints = { enabled = true }
  return config
end

return M
