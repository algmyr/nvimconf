return {
  { 'williamboman/mason.nvim', opts = {} },
  {
    -- TODO(algmyr): Look into the overrides in the readme
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
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
