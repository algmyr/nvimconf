vim.g.python_recommended_style = 0
vim.g.rust_recommended_style = 0

vim.opt.clipboard = 'unnamedplus'
vim.opt.showmode = false

-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 0 -- use tabstop
vim.opt.softtabstop = -1 -- use shiftwidth
vim.opt.breakindent = true
vim.opt.listchars = 'tab:| ,'
vim.opt.list = true

-- Editor behavior
vim.opt.updatetime = 1000
vim.opt.wrap = false
vim.opt.scrolloff = 3
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.wildmode = { 'longest', 'list', 'full' }
vim.opt.completeopt = { 'noinsert', 'menuone', 'noselect' }
vim.opt.backup = false
vim.opt.writebackup = false
-- vim.opt.backupcopy = 'yes'

vim.opt.diffopt = {
  'algorithm:histogram',
  'foldcolumn:0',
  'filler',
}

-- Editor looks
vim.opt.cmdheight = 2
vim.opt.guicursor = {
  'n-v-c-sm:block',
  'i-ci-ve:ver25',
  'r-cr-o:hor20',
  'a:blinkon1',
}

-- Input
vim.opt.mouse = 'a'
vim.opt.mousemodel = 'extend'

function CustomFoldText()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  local summary = line
  local lines = '(' .. line_count .. ' lines)'

  local winid = vim.fn.win_getid()
  local width = vim.fn.winwidth(winid) - vim.fn.getwininfo(winid)[1].textoff
  --if width > 100 then width = 100 end

  local padlen = width - #summary - #lines
  if padlen < 0 then padlen = 0 end

  return summary .. string.rep(' ', padlen) .. lines
end

vim.opt.foldtext = ''

vim.opt.signcolumn = 'auto:1'
vim.opt.foldcolumn = 'auto:3'
vim.opt.fillchars = {
  fold = ' ',
  foldopen = '╭',
  foldclose = '╶',
  foldsep = '│',
}

vim.diagnostic.config {
  virtual_lines = {
    current_line = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
      [vim.diagnostic.severity.HINT] = ' ',
    },
    -- linehl = {
    --   [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
    --   [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
    --   [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
    --   [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    -- },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    },
  },
}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  severity_sort = true,
})

vim.filetype.add {
  extension = {
    frag = 'glsl',
  },
}
