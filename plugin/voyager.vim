" voyager - Minimal file explorer
" Maintainer: obcat <obcat@icloud.com>
" License:    MIT License

if exists('g:loaded_voyager')
  finish
endif
let g:loaded_voyager = 1

augroup voyager
  autocmd!
  autocmd BufEnter * call s:on_bufenter()
  autocmd VimEnter *
    \ if exists('#FileExplorer')
    \| autocmd! FileExplorer
    \|endif
augroup END

function s:on_bufenter() abort
  let file = expand('%:p')
  if isdirectory(file)
    call voyager#init(file)
  endif
endfunction
