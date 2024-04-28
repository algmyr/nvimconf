function UpdateVcsCmds()
  let s:git_commit = printf('HEAD~%d', g:target_commit)
  let g:signify_vcs_cmds.git = 'git diff --no-color --no-ext-diff -U0 -w ' .. s:git_commit .. ' -- %f'
  let g:signify_vcs_cmds_diffmode.git = 'git show ' .. s:git_commit .. ':./%f'

  let s:hg_commit = printf('.~%d', g:target_commit)
  let g:signify_vcs_cmds.hg = 'hg diff --config extensions.color=! --config defaults.diff= --nodates -U0 --rev ' .. s:hg_commit .. ' -- %f'
  let g:signify_vcs_cmds_diffmode.hg = 'hg cat --config extensions.color=! --rev ' .. s:hg_commit .. ' -- %f'

  let s:jj_commit = printf('roots(ancestors(@, %d))', g:target_commit + 2)
  let g:signify_vcs_cmds.jj = 'jj diff --git --context=0 --from "' .. s:jj_commit .. '" --to "@" -- %f'
  let g:signify_vcs_cmds_diffmode.jj = 'jj cat -r "' .. s:jj_commit .. '" -- %f'
endfunction

function ChangeTargetCommit(older_or_younger)
  if a:older_or_younger ==# 'older'
    let g:target_commit += 1
  elseif g:target_commit==#0
    echom 'No timetravel! Cannot diff against HEAD~-1'
    return
  else
    let g:target_commit -= 1
  endif

  call UpdateVcsCmds()

  let l:output_msg = printf('%s%d', 'Now diffing against HEAD~', g:target_commit)
  echom l:output_msg
endfunction

let g:target_commit = 0
command! SignifyOlder call ChangeTargetCommit('older')
command! SignifyNewer call ChangeTargetCommit('younger')

nnoremap [r :SignifyOlder<CR>
nnoremap ]r :SignifyNewer<CR>


let g:signify_sign_add               = '▏'  " '+'
let g:signify_sign_delete            = '▁'  " '_'
let g:signify_sign_delete_first_line = '▔'  " '‾'
let g:signify_sign_change            = '▏'  " '!'
let g:signify_sign_change_delete     = g:signify_sign_change . g:signify_sign_delete_first_line
