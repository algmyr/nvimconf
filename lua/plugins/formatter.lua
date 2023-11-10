return {
  "mhartington/formatter.nvim",
  config = function() -- {{{
    require("formatter").setup {
      logging = true,
      log_level = vim.log.levels.WARNING,
      filetype = {
        c = require("formatter.filetypes.c").clangformat,
        cpp = require("formatter.filetypes.c").clangformat,
        cs = require("formatter.filetypes.cs").clangformat,
        go = require("formatter.filetypes.go").gofmt,
        javascript = require("formatter.filetypes.javascript").clangformat,
        json = require("formatter.filetypes.json").jq,
        lua = require("formatter.filetypes.lua").stylua,
        python = {
          {
            exe = "ruff format",
            args = { "-q", "--preview", "-" },
            stdin = true,
          },
          {
            exe = "ruff check",
            args = { "--select", "I", "--fix", "-" },
            stdin = true,
          },
        },
        rust = {
          function()
            return {
              exe = "~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustfmt",
              stdin = true,
            }
          end,
        },
        sh = require("formatter.filetypes.sh").shfmt,
        typescript = require("formatter.filetypes.typescript").clangformat,

        ["*"] = {
          require("formatter.filetypes.any").remove_trailing_whitespace,
        },
      },
    }
  end -- }}}
}

-- vim: set fdm=marker:
