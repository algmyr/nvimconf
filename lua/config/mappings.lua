local m = require 'mapping'

m.mappings 'signify' {
  ['<leader>s'] = {
    f = m.normal { '<cmd>SignifyFold!<CR>', 'Fold' },
    u = m.normal { '<cmd>SignifyHunkUndo<CR>', 'Hunk undo' },
    d = m.normal { '<cmd>SignifyHunkDiff<CR>', 'Hunk diff' },
    D = m.normal { '<cmd>SignifyDiff<CR>', 'Diff' },
    l = m.normal { '<cmd>SignifyList<CR>', 'List' },
    t = m.normal { '<cmd>SignifyToggle<CR>', 'Toggle' },
    h = m.normal { '<cmd>SignifyToggleHighlight<CR>', 'Toggle highlight' },
    r = m.normal { '<cmd>SignifyRefresh<CR>', 'Refresh' },
  },
}

m.mappings 'iswap' {
  ['<leader>gi'] = m.normal { '<cmd>ISwapWith<CR>', 'Swap' },
  ['<m-left>'] = m.normal { '<cmd>ISwapNodeWithLeft<CR>', 'Swap with left' },
  ['<m-right>'] = m.normal { '<cmd>ISwapNodeWithRight<CR>', 'Swap with right' },
}

m.mappings 'telescope' {
  ['<leader>f'] = {
    f = m.normal { "<cmd>lua require('telescope.builtin').find_files()<cr>", 'Find files' },
    g = m.normal { "<cmd>lua require('telescope.builtin').live_grep()<cr>", 'Live grep' },
    b = m.normal { "<cmd>lua require('telescope.builtin').buffers()<cr>", 'Buffers' },
    h = m.normal { "<cmd>lua require('telescope.builtin').help_tags()<cr>", 'Help tags' },
  },
}

m.mappings 'misc' {
  ['<leader>'] = {
    ['/'] = m.normal { '<cmd>nohlsearch<CR>', 'Unhighlight search' },
    ['bk'] = m.normal { '<cmd>bp <BAR> bd #<cr>', 'Kill buffer' },
    ['cd'] = m.normal { '<cmd>cd %:h<cr>:pwd<cr>', 'cd to current buffer', { silent = false } },
  },
  ['<'] = m.visual { '<gv', 'Dedent selection' },
  ['>'] = m.visual { '>gv', 'Indent selection' },
  ['Q'] = m.normal { '@q', 'Replay the q macro' },
  ---@diagnostic disable-next-line: missing-fields
  ['<space><space>'] = m.normal { function() require('notify').dismiss {} end, 'Dismiss notification' },
}
