return {
  "romainl/vim-qf",
  "stefandtw/quickfix-reflector.vim",
  config = function()
    vim.cmd('runtime quickfix.vim')
  end
}
