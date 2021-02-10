" voyager - Minimal file explorer
" Maintainer: obcat <obcat@icloud.com>
" License:    MIT License

let s:keepalt = get(g:, 'voyager_keepalt', 0)
  \ ? 'keepalt'
  \ : ''
let s:keepjumps = get(g:, 'voyager_keepjumps', 0)
  \ ? 'keepjumps'
  \ : ''
let s:msgs = #{
  \ error: '(failed to retrieve file list)',
  \ nofiles: '(no files)',
  \ }

function! voyager#init() abort "{{{
  let file = expand('%:p')
  if !isdirectory(file)
    return
  endif
  if get(b:, 'voyager_initialized', 0)
    if empty(getline('.'))
      call voyager#util#echoerr('Type "r" or keys you mapped to reload.')
    endif
    return
  endif
  " NOTE: "curdir" has a path separator at the end.
  let curdir = file
  let b:voyager_curdir = curdir

  " See ":help special-buffers".
  setlocal buftype=nowrite
  setlocal bufhidden=delete
  setlocal noswapfile

  setlocal nowrap
  setlocal matchpairs=
  setlocal filetype=voyager

  setlocal modifiable
  call s:set_filenames(curdir)
  setlocal nomodifiable

  call s:focus_on_altfile()
  let b:voyager_initialized = 1
endfunction "}}}

function s:set_filenames(dir) abort "{{{
  let filenames = s:get_filenames(a:dir)
  " Prepend ":silent" command to suppress "--No lines in buffer--" message.
  silent keepjumps % delete _
  call setline(1, filenames)
endfunction "}}}

" Returns a list of file names in specified directory.
function s:get_filenames(dir) abort "{{{
  let show_hidden = get(b:, 'voyager_show_hidden',
    \               get(g:, 'voyager_show_hidden',
    \ 1))
  let Filter = show_hidden
    \ ? 1
    \ : {file -> file.name !~ '^\.'}
  try
    let files = readdirex(a:dir, Filter, #{sort: 'none'})
  catch
    call voyager#util#echoerr(v:exception)
    let b:voyager_error = 1
    return [s:msgs.error]
  endtry
  let b:voyager_error = 0
  if empty(files)
    let b:voyager_nofiles = 1
    return [s:msgs.nofiles]
  endif
  let b:voyager_nofiles = 0
  call map(files, {_, file -> s:add_isdir(file)})
  call sort(files, function('s:compare'))
  let filenames = map(files, {_, file -> file.name . (file.isdir ? '/' : '')})
  return filenames
endfunction "}}}

" Set cursor on alternate file.
function s:focus_on_altfile() abort "{{{
  let altfile = expand('#:p')
  if empty(altfile) || isdirectory(altfile)
    return
  endif
  let altfilename = altfile ->fnamemodify(':t')
  let pattern = s:very_nomagic(altfilename)
  call search(pattern, 'c')
endfunction "}}}

" Add new entry with "isidir" key. The value is:
"   * 1 if specified file is directory or symlink to directory,
"   * 0 if not.
function s:add_isdir(file) abort "{{{
  let file = deepcopy(a:file)
  let file.isdir = (file.type is# 'dir') || (file.type is# 'linkd')
  return file
endfunction "}}}

function s:compare(file1, file2) abort "{{{
  let f1 = a:file1
  let f2 = a:file2
  if f1.isdir != f2.isdir
    " Directory first
    return f1.isdir ? -1 : +1
  endif
  let n1 = f1.name
  let n2 = f2.name
  let l1 = len(n1)
  let l2 = len(n2)
  let maxdepth = get(g:, 'voyager_sort_maxdepth', 99)
  for i in range(0, min([l1, l2, maxdepth]) - 1)
    if n1[i] is# n2[i]
      continue
    endif
    " Dictionary order
    return (n1[i] > n2[i]) ? +1 : -1
  endfor
  " Shorter first
  return (l1 < l2) ? -1 : +1
endfunction "}}}

function s:very_nomagic(text) abort "{{{
  return printf('\V\^%s\$', escape(a:text, '\'))
endfunction "}}}

function! voyager#open() abort "{{{
  let curdir = get(b:, 'voyager_curdir', '')
  if empty(curdir)
    call voyager#util#echoerr(
      \ 'Internal error: Current directory not found.',
      \ 'Try to type "r" or keys you mapped to reload.',
      \ )
    return
  endif
  let line = getline('.')
  if (line is# s:msgs.nofiles) && get(b:, 'voyager_nofiles', 0)
    call voyager#util#beep()
    return
  endif
  let file = curdir . line
  exe s:keepalt s:keepjumps 'edit' fnameescape(file)
endfunction "}}}

function! voyager#up() abort "{{{
  let curdir = get(b:, 'voyager_curdir', '')
  if empty(curdir)
    call voyager#util#echoerr(
      \ 'Internal error: Current directory not found.',
      \ 'Try to type "r" or keys you mapped to reload.',
      \ )
    return
  endif
  if curdir is# '/'
    call voyager#util#beep()
    return
  endif
  " NOTE: "curdir" has a path separator at the end.
  let parentdir = curdir ->fnamemodify(':h:h')
  if !isdirectory(parentdir)
    call voyager#util#echoerr(printf('Unexpected error: "%s" is not directory.', parentdir))
    return
  endif
  exe s:keepalt s:keepjumps 'edit' fnameescape(parentdir)
  " Set cursor on previous directory.
  let prevdirname = curdir ->fnamemodify(':h:t')
  let pattern = s:very_nomagic(prevdirname . '/')
  call search(pattern, 'c')
endfunction "}}}

function! voyager#reload() abort "{{{
  let filename = getline('.')
  let b:voyager_initialized = 0
  call voyager#init()
  " Restore cursor position if possible.
  let pattern = s:very_nomagic(filename)
  call search(pattern, 'c')
endfunction "}}}

function! voyager#toggle_hidden() abort "{{{
  let show_hidden = get(b:, 'voyager_show_hidden',
    \               get(g:, 'voyager_show_hidden',
    \ 1))
  let b:voyager_show_hidden = !show_hidden
  call voyager#reload()
endfunction "}}}

" This is called from syntax/voyager.vim.
function! voyager#_define_syntax() abort "{{{
  let delimiter = '='
  syntax match voyagerDirectory =^.\+/$=
  exe 'syntax match voyagerNoFiles' delimiter . s:very_nomagic(s:msgs.nofiles) . delimiter
  exe 'syntax match voyagerError'   delimiter . s:very_nomagic(s:msgs.error)   . delimiter
  hi! default link voyagerDirectory Directory
  hi! default link voyagerNoFiles Comment
  hi! default link voyagerError WarningMsg
endfunction "}}}
