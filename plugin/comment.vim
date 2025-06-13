" TODO(algmyr): Migrate to lua?
let g:hideComments = 0
function! ToggleComments()
    let g:hideComments = 1 - g:hideComments
    if g:hideComments == 1
        hi! Invisible guifg=bg ctermfg=black
        hi! link Comment Invisible
    else
        hi! link Comment Comment
    endif
endfunction
map <space>c :call ToggleComments()<cr>
