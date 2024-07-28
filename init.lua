vim.g.mapleader = ','
vim.g.maplocalleader = '-'

-- This is a hack, but apparently if you don't source early
-- you run into issues with packages using the default config.
require 'config.mappings'
require 'config.settings'

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
    path = '~/git',
  },
  change_detection = {
    notify = false,
  },
})
