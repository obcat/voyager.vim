" voyager - Minimal file explorer
" Maintainer: obcat <obcat@icloud.com>
" License:    MIT License

if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

nnoremap <buffer> <Plug>(voyager-open)          <Cmd>call voyager#open()<CR>
nnoremap <buffer> <Plug>(voyager-up)            <Cmd>call voyager#up()<CR>
nnoremap <buffer> <Plug>(voyager-home)          <Cmd>call voyager#home()<CR>
nnoremap <buffer> <Plug>(voyager-reload)        <Cmd>call voyager#reload()<CR>
nnoremap <buffer> <Plug>(voyager-toggle-hidden) <Cmd>call voyager#toggle_hidden()<CR>

if get(g:, 'voyager_no_default_keymappings', 0)
  finish
endif

if !hasmapto('<Plug>(voyager-open)', 'n')
  nmap <buffer> <nowait> o <Plug>(voyager-open)
endif
if !hasmapto('<Plug>(voyager-up)', 'n')
  nmap <buffer> <nowait> u <Plug>(voyager-up)
endif
if !hasmapto('<Plug>(voyager-reload)', 'n')
  nmap <buffer> <nowait> r <Plug>(voyager-reload)
endif
if !hasmapto('<Plug>(voyager-toggle-hidden)', 'n')
  nmap <buffer> <nowait> . <Plug>(voyager-toggle-hidden)
endif
