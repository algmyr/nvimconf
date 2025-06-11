local m = require 'mapping'

m.mappings 'vcsigns' {
  ['[r'] = m.normal {
    function() require('vcsigns').actions.target_older_commit(0, vim.v.count1) end,
    'Move diff target back',
  },
  [']r'] = m.normal {
    function() require('vcsigns').actions.target_newer_commit(0, vim.v.count1) end,
    'Move diff target forward',
  },
  [']c'] = m.normal { function() require('vcsigns').actions.next_hunk(0, vim.v.count1) end, 'Go to next hunk' },
  ['[c'] = m.normal { function() require('vcsigns').actions.prev_hunk(0, vim.v.count1) end, 'Go to previous hunk' },
  [']C'] = m.normal { function() require('vcsigns').actions.next_hunk(0, 9999) end, 'Go to last hunk' },
  ['[C'] = m.normal { function() require('vcsigns').actions.prev_hunk(0, 9999) end, 'Go to first hunk' },
  ['<leader>su'] = m.normal { function() require('vcsigns').actions.hunk_undo(0) end, 'Undo the hunk under the cursor' },
  ['<leader>sd'] = m.normal {
    function() require('vcsigns').actions.show_diff(0) end,
    'Show diff of hunk under the cursor',
  },
  ['<leader>sf'] = m.normal {
    function() require('vcsigns').fold.toggle() end,
    'Fold outside hunks',
  },
  ['<space>h'] = {
    operator = { function() require('vcsigns.textobj').select_hunk(0) end, 'Hunk under cursor' },
    visual = { function() require('vcsigns.textobj').select_hunk(0) end, 'Hunk under cursor' },
  },
}

m.mappings 'vcmarkers' {
  [']m'] = m.normal { function() require('vcmarkers').actions.next_marker(0, vim.v.count1) end, 'Go to next marker' },
  ['[m'] = m.normal { function() require('vcmarkers').actions.prev_marker(0, vim.v.count1) end, 'Go to previous marker' },
  ['<space>ms'] = m.normal {
    function() require('vcmarkers').actions.select_section(0) end,
    'Select the section under the cursor',
  },
  ['<space>mf'] = m.normal { function() require('vcmarkers').fold.toggle() end, 'Fold outside markers' },
  ['<space>mc'] = m.normal {
    function() require('vcmarkers').actions.cycle_marker(0) end,
    'Cycle marker representations',
  },
}

m.mappings 'iswap' {
  ['<leader>gi'] = m.normal { '<cmd>ISwapWith<CR>', 'Swap' },
  ['<m-left>'] = m.normal { '<cmd>ISwapNodeWithLeft<CR>', 'Swap with left' },
  ['<m-right>'] = m.normal { '<cmd>ISwapNodeWithRight<CR>', 'Swap with right' },
}

m.mappings 'telescope' {
  ['<space>f'] = {
    f = m.normal { "<cmd>lua require('telescope.builtin').find_files()<cr>", 'Find files' },
    g = m.normal { "<cmd>lua require('telescope.builtin').live_grep()<cr>", 'Live grep' },
    b = m.normal { "<cmd>lua require('telescope.builtin').buffers()<cr>", 'Buffers' },
    h = m.normal { "<cmd>lua require('telescope.builtin').help_tags()<cr>", 'Help tags' },
  },
}

m.mappings 'misc' {
  [';'] = {
    normal = { ':', '', { silent = false } },
    visual = { ':', '', { silent = false } },
  },
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
