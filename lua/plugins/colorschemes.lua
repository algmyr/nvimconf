return {
  {
    'algmyr/vim-wombat-lua',
    dependencies = { 'tjdevries/colorbuddy.nvim' },
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.cmd 'color wombat_lua'
    end,
  },
}
