vim9script
# voyager - Minimal file explorer
# Maintainer: obcat <obcat@icloud.com>
# License:    MIT License

import messages from '../import/voyager/messages.vim'

def voyager#init(dir: string)
  if get(b:, 'voyager_initialized', false) && getline('.') != ''
    return
  endif

  # This will source "ftplugin/voyager.vim" and "syntax/voyager.vim."
  setlocal filetype=voyager

  setlocal modifiable
  ListContents(dir)
  setlocal nomodifiable

  if b:voyager_state is 'files'
    const altfile = expand('#:p')
    if altfile != '' && !isdirectory(altfile)
      voyager#set_cursor(fnamemodify(altfile, ':t'))
    endif
  endif
  b:voyager_curdir = dir
  b:voyager_initialized = true
enddef

def voyager#set_cursor(text: string)
  const pattern = printf('\V\^%s\$', escape(text, '\'))
  search(pattern, 'c')
enddef

def ListContents(dir: string)
  var filenames: list<string>
  try
    filenames = voyager#file#get_filenames(dir)
  catch
    # HACK: Avoid error message from being cleared.
    augroup voyager-echoerr
      autocmd!
      autocmd SafeStateAgain * ++once voyager#util#echoerr(v:exception)
    augroup END
    ReplaceAllLines([messages.error])
    b:voyager_state = 'message'
    return
  endtry
  if empty(filenames)
    ReplaceAllLines([messages.nofiles])
    b:voyager_state = 'message'
    return
  endif
  ReplaceAllLines(filenames)
  b:voyager_state = 'files'
enddef

def ReplaceAllLines(lines: list<string>)
  # NOTE: "silent" is used to suppress "--No lines in buffer--" message.
  silent keepjumps :% delete _
  setline(1, lines)
enddef
