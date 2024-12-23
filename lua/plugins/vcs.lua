return {
  {
    'sjl/splice.vim',
    config = function()
      vim.g.splice_initial_layout_grid = 1
      vim.g.splice_initial_diff_grid = 1
    end,
  },
  {
    -- 'mhinz/vim-signify',
    enabled = false,
    dir = "~/jj/vim-signify",
    build = ':UpdateRemotePlugins',
    config = function()
      require('sy').setup{}
      vim.cmd 'runtime signify.vim'
    end,
  },
  {
    'algmyr/vcsigns.nvim',
    name = "vcsigns",
    opts = {},
  },
}
