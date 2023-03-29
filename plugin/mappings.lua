require 'mapping'

nmap('<leader>/', ':nohlsearch<CR>')

nmap('<leader>bk', ':bp <BAR> bd #<cr>')

-- Other mappings
nmap('-', '"ldd"lp')
nmap('_', 'k"ldd"lpk')
vmap('<', '<gv')
vmap('>', '>gv')
nmap('Q', '@q')

nmap('<leader>sf', ':SignifyFold!<CR>')
nmap('<leader>su', ':SignifyHunkUndo<CR>')
nmap('<leader>sd', ':SignifyHunkDiff<CR>')
nmap('<leader>sD', ':SignifyDiff<CR>')
nmap('<leader>sl', ':SignifyList<CR>')
nmap('<leader>st', ':SignifyToggle<CR>')
nmap('<leader>sh', ':SignifyToggleHighlight<CR>')
nmap('<leader>sr', ':SignifyRefresh<CR>')

nmap('<leader>gi', ':ISwapWith<CR>')
nmap('<m-left>', ':ISwapNodeWithLeft<CR>')
nmap('<m-right>', ':ISwapNodeWithRight<CR>')

nmap('<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>')
nmap('<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>')
nmap('<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>')
nmap('<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>')

nmap('<leader>cd', ':cd %:h<cr>:pwd<cr>', {silent=false})

vim.api.nvim_create_user_command(
  'Wikt',
  function(opts)
    local url = 'https://' .. opts.args .. '.wiktionary.org/wiki/' .. vim.call('expand','<cword>')
    io.popen('xdg-open ' .. url)
  end,
  { nargs = 1 }
)
