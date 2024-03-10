require 'mapping'

nmap('<leader>/', ':nohlsearch<CR>', 'Unhighlight search')

nmap('<leader>bk', ':bp <BAR> bd #<cr>', 'Kill buffer')

-- Other mappings
vmap('<', '<gv', 'Dedent selection')
vmap('>', '>gv', 'Indent selection')
nmap('Q', '@q', 'Replay the q macro')

nmap('<leader>sf', ':SignifyFold!<CR>', 'Fold (signify)')
nmap('<leader>su', ':SignifyHunkUndo<CR>', 'Hunk undo (signify)')
nmap('<leader>sd', ':SignifyHunkDiff<CR>', 'Hunk diff (signify)')
nmap('<leader>sD', ':SignifyDiff<CR>', 'Diff (signify)')
nmap('<leader>sl', ':SignifyList<CR>', 'List (signify)')
nmap('<leader>st', ':SignifyToggle<CR>', 'Toggle (signify)')
nmap('<leader>sh', ':SignifyToggleHighlight<CR>', 'Toggle highlight (signify)')
nmap('<leader>sr', ':SignifyRefresh<CR>', 'Refresh (signify)')

nmap('<leader>gi', ':ISwapWith<CR>', 'Swap (iswap)')
nmap('<m-left>', ':ISwapNodeWithLeft<CR>', 'Swap with left (iswap)')
nmap('<m-right>', ':ISwapNodeWithRight<CR>', 'Swap with right (iswap)')

nmap('<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', 'Find files (telescope)')
nmap('<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', 'Live grep (telescope)')
nmap('<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', 'Buffers (telescope)')
nmap('<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', 'Help tags (telescope)')

nmap('<leader>cd', ':cd %:h<cr>:pwd<cr>', 'cd to current buffer', {silent=false})
---@diagnostic disable-next-line: missing-parameter
nmap('<space><space>', function() require('notify').dismiss() end, 'Dismiss notification')

vim.api.nvim_create_user_command(
  'Wikt',
  function(opts)
    local url = 'https://' .. opts.args .. '.wiktionary.org/wiki/' .. vim.call('expand','<cword>')
    io.popen('xdg-open ' .. url)
  end,
  { nargs = 1 }
)
