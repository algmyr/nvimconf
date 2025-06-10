return {
  {
    'sjl/splice.vim',
    config = function()
      vim.g.splice_initial_layout_grid = 1
      vim.g.splice_initial_diff_grid = 1
    end,
  },
  {
    "algmyr/vcsigns.nvim",
    config = function()
      require('vcsigns').setup {
        target_commit = 1,
      }
    end,
  },
  {
    "algmyr/vcmarkers.nvim",
    config = function()
      require('vcmarkers').setup {}
    end,
  },
}
