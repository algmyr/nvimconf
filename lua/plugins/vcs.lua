return {
  {
    'algmyr/vcsigns.nvim',
    dependencies = { 'algmyr/vclib.nvim' },
    config = function()
      require('vcsigns').setup {
        target_commit = 1,
      }
    end,
  },
  {
    'algmyr/vcmarkers.nvim',
    dependencies = { 'algmyr/vclib.nvim' },
    config = function() require('vcmarkers').setup {} end,
  },
  {
    'algmyr/vclib.nvim',
  },
}
