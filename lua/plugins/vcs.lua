return {
  "sjl/splice.vim",
  {
    "mhinz/vim-signify",
    build = ":UpdateRemotePlugins",
    config = function()
      vim.cmd "runtime signify.vim"
    end,
  },
}
