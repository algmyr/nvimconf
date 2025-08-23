return {
  {
    'algmyr/vcsigns.nvim',
    config = function()
      require('vcsigns').setup {
        target_commit = 1,
        diff_opts = {
          algorithm = 'histogram',
          linematch = 60,
          indent_heuristic = true,
        },
      }
    end,
  },
  {
    'algmyr/vcmarkers.nvim',
    config = function() require('vcmarkers').setup {} end,
  },
  {
    'algmyr/vclib.nvim',
  },
  {
    'acarapetis/nvim-treesitter-jjconfig',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    lazy = false,
    opts = { ensure_installed = true },
  },
}
