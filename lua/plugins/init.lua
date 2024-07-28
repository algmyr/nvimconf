local m = require("mapping")

return {
  "editorconfig/editorconfig-vim",

  -- tosort
  "wsdjeg/vim-fetch",
  {
    "fedepujol/move.nvim",
    config = function()
      require("move").setup {}

      m.mappings "move" {
        ["-"] = {
          normal = { "<cmd>MoveLine(1)<cr>", "Move line down" },
          visual = { ":MoveBlock(1)<cr>", "Move block down" },
        },
        ["_"] = {
          normal = { "<cmd>MoveLine(-1)<cr>", "Move line up" },
          visual = { ":MoveBlock(-1)<cr>", "Move block up" },
        },
      }
    end,
  },
}
