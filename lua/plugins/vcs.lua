return {
  {
    'algmyr/vcsigns.nvim',
    config = function()
      require('vcsigns').setup {
        target_commit = 1,
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
}
