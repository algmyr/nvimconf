vim.g.python_recommended_style = 0
vim.g.rust_recommended_style = 0

vim.o.clipboard = 'unnamedplus'
vim.o.showmode = false

-- Indentation
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 0   -- use tabstop
vim.o.softtabstop = -1 -- use shiftwidth
vim.o.breakindent = true
vim.o.listchars = 'tab:| ,'
vim.o.list = true

-- Editor behavior
vim.o.updatetime = 1000
vim.o.wrap = false
vim.o.scrolloff = 3
vim.o.backspace = 'indent,eol,start'
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.wildmode = 'longest,list,full'
vim.o.completeopt = 'noinsert,menuone,noselect'

-- Editor looks
vim.o.cmdheight = 2
vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkon1'

-- Input
vim.o.mouse = "a"
vim.o.mousemodel = "extend"

function CustomFoldText()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  local summary = line
  local lines = "(" .. line_count .. " lines)"

  local winid = vim.fn.win_getid()
  local width = vim.fn.winwidth(winid) - vim.fn.getwininfo(winid)[1].textoff
  --if width > 100 then width = 100 end

  local padlen = width - #summary - #lines
  if padlen < 0 then
    padlen = 0
  end

  return summary .. string.rep(" ", padlen) .. lines
end

vim.o.foldtext = 'v:lua.CustomFoldText()'

vim.o.signcolumn = 'auto:1'
vim.o.foldcolumn = 'auto:3'
vim.o.fillchars = 'foldclose:╶,foldopen:╭,foldsep:│,fold: '

-- Hacky sign stuff.
local signs = {
  Info = " ",
  Hint = " ",
  Warn = " ",
  Error = " ",
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        severity_sort = true
    }
)

vim.g.signify_priority = 2

vim.filetype.add({
  extension = {
    frag = "glsl",
  },
})
