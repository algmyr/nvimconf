return {
  {
    'algmyr/vim-wombat-lua',
    dependencies = { 'rktjmp/lush.nvim' },
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.cmd 'color wombat_lua'
    end,
  },
}
