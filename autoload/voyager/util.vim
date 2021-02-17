" voyager - Minimal file explorer
" Maintainer: obcat <obcat@icloud.com>
" License:    MIT License

function voyager#util#echoerr(...) abort
  echohl ErrorMsg
  for msg in a:000
    echomsg printf('[voyager] %s', msg)
  endfor
  echohl None
endfunction

function voyager#util#beep() abort
  execute 'normal! "\<ESC>"'
endfunction
