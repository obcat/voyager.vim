" voyager - Minimal file explorer
" Maintainer: obcat <obcat@icloud.com>
" License:    MIT License

let g:voyager#messages = #{
  \ error:   '(error)',
  \ nofiles: '(no files)',
  \ }

function voyager#init(dir) abort
  if get(b:, 'voyager_initialized', 0) && !empty(getline('.'))
    return
  endif

  " This will source "ftplugin/voyager.vim" and "syntax/voyager.vim."
  setlocal filetype=voyager

  setlocal modifiable
  call s:list_contents(a:dir)
  setlocal nomodifiable

  if b:voyager_state is 'files'
    let altfile = expand('#:p')
    if !empty(altfile) && !isdirectory(altfile)
      call voyager#set_cursor(fnamemodify(altfile, ':t'))
    endif
  endif

  let b:voyager_curdir = a:dir
  let b:voyager_initialized = 1
endfunction

function voyager#set_cursor(text) abort
  let pattern = printf('\V\^%s\$', escape(a:text, '\'))
  call search(pattern, 'c')
endfunction

function s:list_contents(dir) abort
  try
    let filenames = voyager#file#get_filenames(a:dir)
  catch
    call voyager#util#echoerr(v:exception)
    call s:replace_all_lines([g:voyager#messages.error])
    let b:voyager_state = 'message'
    return
  endtry
  if empty(filenames)
    call s:replace_all_lines([g:voyager#messages.nofiles])
    let b:voyager_state = 'message'
    return
  endif
  let b:voyager_state = 'files'
  call s:replace_all_lines(filenames)
endfunction

function s:replace_all_lines(lines) abort
  " Prepend "silent" to suppress "--No lines in buffer--" message.
  silent keepjumps % delete _
  call setline(1, a:lines)
endfunction
