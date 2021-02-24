vim9script
# voyager - Minimal file explorer
# Maintainer: obcat <obcat@icloud.com>
# License:    MIT License

if exists('g:loaded_voyager')
  finish
endif
g:loaded_voyager = true

augroup voyager
  autocmd!
  autocmd BufEnter * OnBufenter()
  autocmd VimEnter *
    \ if exists('#FileExplorer')
    |   autocmd! FileExplorer
    | endif
augroup END

def OnBufenter()
  const file = expand('%:p')
  if isdirectory(file)
    voyager#init(file)
  endif
enddef
