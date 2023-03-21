nmap <Leader>cc <Plug>(qf_qf_toggle)

" Go to previous location
nmap [q <Plug>(qf_qf_previous)zz

" Go to next location
nmap ]q <Plug>(qf_qf_next)zz

function! QuickfixMapping()
  " Go to the previous location and stay in the quickfix window
  nmap <buffer> K <Plug>(qf_qf_previous)zz<C-w>w

  " Go to the next location and stay in the quickfix window
  nmap <buffer> J <Plug>(qf_qf_next)zz<C-w>w
endfunction

augroup quickfix_group
    autocmd!
    autocmd filetype qf call QuickfixMapping()
augroup END
