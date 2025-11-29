local M = {}

function M.toggle_comments()
  vim.b.algmyr_hide_comments = not vim.b.algmyr_hide_comments
  if vim.b.algmyr_hide_comments then
    vim.cmd 'hi! Invisible guifg=bg ctermfg=black'
    vim.cmd 'hi! link Comment Invisible'
  else
    vim.cmd 'hi! link Comment Comment'
  end
end

return M
