" voyager - Minimal file explorer
" Maintainer: obcat <obcat@icloud.com>
" License:    MIT License

if exists('b:current_syntax')
  finish
endif
let b:current_syntax = 'voyager'

syntax match voyagerDirectory =^.\+/$=
execute 'syntax match voyagerNoFiles' '=' . g:voyager#messages.nofiles . '='
execute 'syntax match voyagerError'   '=' . g:voyager#messages.error   . '='
highlight default link voyagerDirectory Directory
highlight default link voyagerNoFiles   Comment
highlight default link voyagerError     ErrorMsg
