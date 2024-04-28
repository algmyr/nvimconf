return {
  'stevearc/conform.nvim',
  config = function()
    local conform = require 'conform'

    conform.setup {
      formatters_by_ft = {
        -- javascript = { "prettier" },
        -- typescript = { "prettier" },
        -- javascriptreact = { "prettier" },
        -- typescriptreact = { "prettier" },
        -- svelte = { "prettier" },
        -- css = { "prettier" },
        -- html = { "prettier" },
        -- json = { "prettier" },
        -- yaml = { "prettier" },
        -- markdown = { "prettier" },
        -- graphql = { "prettier" },
        -- lua = { "stylua" },
        -- python = { "isort", "ruff_format" },

        c = { 'clang-format' },
        cpp = { 'clang-format' },
        cs = { 'clang-format' },
        go = { 'gofmt' },
        javascript = { 'clang-format' },
        json = { 'jq' },
        lua = { 'stylua' },
        python = { 'ruff_format' },
        rust = { 'rustfmt' },
        sh = { 'shfmt' },
        typescript = { 'clang-format' },
      },
    }

    vim.api.nvim_create_user_command('Format', function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ['end'] = { args.line2, end_line:len() },
        }
      end
      require('conform').format { async = true, lsp_fallback = true, range = range }
    end, { range = true })
  end,
}

-- return {
--   "mhartington/formatter.nvim",
--   config = function() -- {{{
--     require("formatter").setup {
--       logging = true,
--       log_level = vim.log.levels.WARNING,
--       filetype = {
--         c = require("formatter.filetypes.c").clangformat,
--         cpp = require("formatter.filetypes.c").clangformat,
--         cs = require("formatter.filetypes.cs").clangformat,
--         go = require("formatter.filetypes.go").gofmt,
--         javascript = require("formatter.filetypes.javascript").clangformat,
--         json = require("formatter.filetypes.json").jq,
--         lua = require("formatter.filetypes.lua").stylua,
--         python = {
--           {
--             exe = "ruff format",
--             args = { "-q", "--preview", "-" },
--             stdin = true,
--           },
--           {
--             exe = "ruff check",
--             args = { "--select", "I", "--fix", "-" },
--             stdin = true,
--           },
--         },
--         rust = {
--           function()
--             return {
--               exe = "~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustfmt",
--               stdin = true,
--             }
--           end,
--         },
--         sh = require("formatter.filetypes.sh").shfmt,
--         typescript = require("formatter.filetypes.typescript").clangformat,
--
--         ["*"] = {
--           require("formatter.filetypes.any").remove_trailing_whitespace,
--         },
--       },
--     }
--   end, -- }}}
-- }
--
-- -- vim: set fdm=marker:
