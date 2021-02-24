vim9script
# voyager - Minimal file explorer
# Maintainer: obcat <obcat@icloud.com>
# License:    MIT License

if exists('b:current_syntax')
  finish
endif
b:current_syntax = 'voyager'

import messages from '../import/voyager/messages.vim'

syntax match voyagerDirectory =^.\+/$=
execute 'syntax match voyagerNoFiles' '=^' .. messages.nofiles .. '$='
execute 'syntax match voyagerError'   '=^' .. messages.error   .. '$='
highlight default link voyagerDirectory Directory
highlight default link voyagerNoFiles   Comment
highlight default link voyagerError     ErrorMsg
