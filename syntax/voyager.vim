" voyager - Minimal file explorer
" Maintainer: obcat <obcat@icloud.com>
" License:    MIT License

if exists('b:current_syntax')
  finish
endif

call voyager#_define_syntax()

let b:current_syntax = 'voyager'
