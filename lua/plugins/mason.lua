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
      -- Auto setup
      local mason_lspconfig = require 'mason-lspconfig'
      mason_lspconfig.setup()
    end, -- }}}
  },
}

-- vim: set fdm=marker:
