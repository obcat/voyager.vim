" voyager - Minimal file explorer
" Maintainer: obcat <obcat@icloud.com>
" License:    MIT License

if exists('g:loaded_voyager')
  finish
endif

function! s:hijack_netrw() abort
  if exists('#FileExplorer')
    autocmd! FileExplorer
  endif
endfunction

augroup _voyager_
  autocmd!
  autocmd VimEnter * call s:hijack_netrw()
  autocmd BufEnter * call voyager#init()
augroup END

let g:loaded_voyager = 1
