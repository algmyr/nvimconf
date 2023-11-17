return {
  "editorconfig/editorconfig-vim",
  "dhruvasagar/vim-table-mode",
  "godlygeek/tabular",

  -- tosort
  "wsdjeg/vim-fetch",
  {
    'fedepujol/move.nvim',
    config = function()
      -- Normal-mode commands
      nmap('-', ':MoveLine(1)<CR>', 'Move line down')
      nmap('_', ':MoveLine(-1)<CR>', 'Move line up')

      -- Visual-mode commands
      vmap('-', ':MoveBlock(1)<CR>', 'Move block down')
      vmap('_', ':MoveBlock(-1)<CR>', 'Move block up')
    end,
  },
}
