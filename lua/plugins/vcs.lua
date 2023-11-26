return {
  {
    "sjl/splice.vim",
    config = function()
      vim.g.splice_initial_layout_grid = 1
      vim.g.splice_initial_diff_grid = 1
    end,
  },
  {
    "mhinz/vim-signify",
    build = ":UpdateRemotePlugins",
    config = function()
      vim.cmd "runtime signify.vim"
    end,
  },
}
