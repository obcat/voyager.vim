vim9script
# voyager - Minimal file explorer
# Maintainer: obcat <obcat@icloud.com>
# License:    MIT License

def voyager#mapping#open()
  if b:voyager_state is 'message'
    BeepIfNeeded()
    return
  endif
  const file = b:voyager_curdir .. getline('.')
  if isdirectory(file) || filereadable(file)
    const keepalt   = get(g:, 'voyager_keepalt',   false) ? 'keepalt'   : ''
    const keepjumps = get(g:, 'voyager_keepjumps', false) ? 'keepjumps' : ''
    execute keepalt keepjumps 'edit' fnameescape(file)
  else
    voyager#util#echoerr(printf('Error: Cannot open "%s".', file))
  endif
enddef

def voyager#mapping#up()
  const curdir = b:voyager_curdir
  if curdir is '/'
    BeepIfNeeded()
    return
  endif
  # NOTE: "curdir" has a path separator at the end.
  const parentdir = fnamemodify(curdir, ':h:h')
  if !isdirectory(parentdir)
    voyager#util#echoerr(printf('Error: "%s" is not directory.', parentdir))
    return
  endif
  const keepalt   = get(g:, 'voyager_keepalt',   false) ? 'keepalt'   : ''
  const keepjumps = get(g:, 'voyager_keepjumps', false) ? 'keepjumps' : ''
  execute keepalt keepjumps 'edit' fnameescape(parentdir)
  const prevdirname = fnamemodify(curdir, ':h:t')
  voyager#set_cursor(prevdirname .. '/')
enddef

def voyager#mapping#reload()
  const filename = getline('.')
  b:voyager_initialized = false
  doautocmd voyager BufEnter
  voyager#set_cursor(filename)
enddef

def voyager#mapping#toggle_hidden()
  const show_hidden = get(b:, 'voyager_show_hidden',
                      get(g:, 'voyager_show_hidden', true))
  b:voyager_show_hidden = !show_hidden
  voyager#mapping#reload()
enddef


def BeepIfNeeded()
  const nobeep = get(g:, 'voyager_nobeep', &belloff =~ 'error')
  if !nobeep
    voyager#util#beep()
  endif
enddef
