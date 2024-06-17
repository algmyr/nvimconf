return {
  { 'williamboman/mason.nvim', opts = {} },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false, -- This plugin is already lazy
    init = function()
      local config = require('config.lsp_defaults').get_default_config()
      local function code_action() vim.cmd.RustLsp 'codeAction' end
      vim.g.rustaceanvim = {
        tools = {},
        server = {
          on_attach = function(client, bufnr) config.on_attach(client, bufnr) end,
          default_settings = {
            ['rust-analyzer'] = {
              diagnostics = {
                style_lints = {
                  enable = true,
                },
              },
            },
          },
        },
        dap = {},
      }
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'mrcjkb/rustaceanvim',
      'williamboman/mason.nvim',
    },
    config = function() -- {{{
      local config = require('config.lsp_defaults').get_default_config()

      -- Auto setup
      local mason_lspconfig = require 'mason-lspconfig'
      mason_lspconfig.setup()
      mason_lspconfig.setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require('lspconfig')[server_name].setup(config)
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        ['rust_analyzer'] = function() end,
        ['clangd'] = function()
          local capabilities = vim.tbl_extend('force', {}, config.capabilities) -- silly
          capabilities.offsetEncoding = { 'utf-16' }
          require('lspconfig').clangd.setup {
            capabilities = capabilities,
            cmd = {
              'clangd',
              '--background-index',
              '--clang-tidy',
              '--completion-style=bundled',
              '--header-insertion=iwyu',
              '--pch-storage=memory',
              '--inlay-hints=true',
            },
          }
        end,
      }
    end, -- }}}
  },
}

-- vim: set fdm=marker:
