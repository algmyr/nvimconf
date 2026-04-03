vim.g.mapleader = ','
vim.g.maplocalleader = '-'

require 'config'

package.path = package.path .. ';~/.config/nvim/lua/%.lua'

-- These were only added in nvim 0.12
if vim.fn.has 'nvim-0.12' == 1 then
  vim.cmd.packadd 'nvim.undotree'
  vim.cmd.packadd 'nvim.difftool'
end

local plug_adapter = require 'plug_adapter'
plug_adapter.load_plugins_from_dirs({ 'plugins', 'work' }, '~/jj')
