vim.g.mapleader = ','
vim.g.maplocalleader = '-'

require 'config'

package.path = package.path .. ';~/.config/nvim/lua/%.lua'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { import = 'plugins' },
  { import = 'work' },
}, {
  dev = {
    path = '~/jj',
  },
  change_detection = {
    notify = false,
  },
})
