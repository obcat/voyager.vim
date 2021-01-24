" voyager - Minimal file explorer
" Maintainer: obcat <obcat@icloud.com>
" License:    MIT License

function! voyager#util#echoerr(...) abort
  echohl WarningMsg
  for msg in a:000
    echomsg printf('[voyager] %s', msg)
  endfor
  echohl None
endfunction

function! voyager#util#beep() abort
  let belloff = split(&belloff, ',')
  let default = index(belloff, 'error') >= 0
  if !get(g:, 'voyager_nobeep', default)
    exe 'normal! "\<ESC>"'
  endif
endfunction
