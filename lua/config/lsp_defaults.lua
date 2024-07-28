local M = {}

local m = require 'mapping'

local function on_attach(client, bufnr)
  if client.supports_method 'textDocument/inlayHint' then vim.lsp.inlay_hint.enable(true, { bufnr = 0 }) end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

  local bufopts = { buffer = bufnr }
  m.mappings 'LSP' {
    K = m.normal { vim.lsp.buf.hover, 'Hover', bufopts },
    gd = m.normal { vim.lsp.buf.definition, 'Go to definition', bufopts },
    gi = m.normal { vim.lsp.buf.implementation, 'Go to implementation', bufopts },
    gr = m.normal { vim.lsp.buf.references, 'Go to references', bufopts },
    ['<C-k>'] = m.normal { vim.lsp.buf.signature_help, 'Signature help', bufopts },
    ['<space>'] = {
      wa = m.normal { vim.lsp.buf.add_workspace_folder, 'Add workspace folder', bufopts },
      wr = m.normal { vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder', bufopts },
      wl = m.normal {
        function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        'List workspace folders',
        bufopts,
      },
      D = m.normal { vim.lsp.buf.type_definition, 'Go to type definition', bufopts },
      rn = m.normal { vim.lsp.buf.rename, 'Rename', bufopts },
      a = {
        normal = { vim.lsp.buf.code_action, 'Code action', bufopts },
        visual = { vim.lsp.buf.code_action, 'Code action', bufopts },
      },
    },
  }
end

function M.get_default_config()
  local config = require('lspconfig').util.default_config
  config.on_attach = on_attach
  config.capabilities = require('cmp_nvim_lsp').default_capabilities()
  config.inlay_hints = { enabled = true }
  return config
end

return M
