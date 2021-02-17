" voyager - Minimal file explorer
" Maintainer: obcat <obcat@icloud.com>
" License:    MIT License

function voyager#mapping#open() abort
  if b:voyager_state is# 'message'
    call s:beep_if_needed()
    return
  endif
  let file = b:voyager_curdir . getline('.')
  if isdirectory(file) || filereadable(file)
    let keepalt   = get(g:, 'voyager_keepalt',   0) ? 'keepalt'   : ''
    let keepjumps = get(g:, 'voyager_keepjumps', 0) ? 'keepjumps' : ''
    execute keepalt keepjumps 'edit' fnameescape(file)
  else
    call voyager#util#echoerr(printf('Error: Cannot open "%s".', file))
  endif
endfunction

function voyager#mapping#up() abort
  let curdir = b:voyager_curdir
  if curdir is# '/'
    call s:beep_if_needed()
    return
  endif
  " NOTE: "curdir" has a path separator at the end.
  let parentdir = fnamemodify(curdir, ':h:h')
  if !isdirectory(parentdir)
    call voyager#util#echoerr(printf('Error: "%s" is not directory.', parentdir))
    return
  endif
  let keepalt   = get(g:, 'voyager_keepalt',   0) ? 'keepalt'   : ''
  let keepjumps = get(g:, 'voyager_keepjumps', 0) ? 'keepjumps' : ''
  execute keepalt keepjumps 'edit' fnameescape(parentdir)
  let prevdirname = fnamemodify(curdir, ':h:t')
  call voyager#set_cursor(prevdirname . '/')
endfunction

function voyager#mapping#reload() abort
  let filename = getline('.')
  let b:voyager_initialized = 0
  doautocmd voyager BufEnter
  call voyager#set_cursor(filename)
endfunction

function voyager#mapping#toggle_hidden() abort
  let show_hidden = get(b:, 'voyager_show_hidden',
    \               get(g:, 'voyager_show_hidden',
    \ 1))
  let b:voyager_show_hidden = !show_hidden
  call voyager#mapping#reload()
endfunction


function s:beep_if_needed() abort
  if !get(g:, 'voyager_nobeep', &belloff =~# 'error')
    call voyager#util#beep()
  endif
endfunction
