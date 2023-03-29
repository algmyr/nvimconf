let g:target_commit = 0
command! SignifyOlder call ChangeTargetGitCommit('older')
command! SignifyNewer call ChangeTargetGitCommit('younger')

function ChangeTargetGitCommit(older_or_younger)
  if a:older_or_younger ==# 'older'
    let g:target_commit += 1
  elseif g:target_commit==#0
    echom 'No timetravel! Cannot diff against HEAD~-1'
    return
  else
    let g:target_commit -= 1
  endif
  let l:git_command = printf('%s%d%s', 'git diff --no-color --no-ext-diff -U0 HEAD~', g:target_commit, ' -- %f')
  let g:signify_vcs_cmds = {
  \ 'git':      l:git_command,
  \ 'hg':       'hg diff --config extensions.color=! --config defaults.diff= --nodates -U0 -- %f',
  \ 'svn':      'svn diff --diff-cmd %d -x -U0 -- %f',
  \ 'bzr':      'bzr diff --using %d --diff-options=-U0 -- %f',
  \ 'darcs':    'darcs diff --no-pause-for-gui --diff-command="%d -U0 %1 %2" -- %f',
  \ 'fossil':   'fossil diff --unified -c 0 -- %f',
  \ 'cvs':      'cvs diff -U0 -- %f',
  \ 'rcs':      'rcsdiff -U0 %f 2>%n',
  \ 'accurev':  'accurev diff %f -- -U0',
  \ 'perforce': 'p4 info '. sy#util#shell_redirect('%n') . (has('win32') ? ' &&' : ' && env P4DIFF= P4COLORS=') .' p4 diff -du0 %f',
  \ 'tfs':      'tf diff -version:W -noprompt %f',
  \ }
  let l:output_msg = printf('%s%d', 'Now diffing against HEAD~', g:target_commit)
  echom l:output_msg

endfunction

nnoremap [r :SignifyOlder<CR>
nnoremap ]r :SignifyNewer<CR>

let g:signify_sign_add               = '▏'  " '+'
let g:signify_sign_delete            = '▁'  " '_'
let g:signify_sign_delete_first_line = '▔'  " '‾'
let g:signify_sign_change            = '▏'  " '!'
let g:signify_sign_change_delete     = g:signify_sign_change . g:signify_sign_delete_first_line
