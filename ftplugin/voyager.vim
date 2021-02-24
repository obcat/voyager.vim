vim9script
# voyager - Minimal file explorer
# Maintainer: obcat <obcat@icloud.com>
# License:    MIT License

if exists('b:did_ftplugin')
  finish
endif
b:did_ftplugin = true

# See ":help special-buffers".
setlocal buftype=nowrite
setlocal bufhidden=delete
setlocal noswapfile

setlocal nowrap
setlocal matchpairs=

nnoremap <buffer> <Plug>(voyager-open)          <Cmd>call voyager#mapping#open()<CR>
nnoremap <buffer> <Plug>(voyager-up)            <Cmd>call voyager#mapping#up()<CR>
nnoremap <buffer> <Plug>(voyager-reload)        <Cmd>call voyager#mapping#reload()<CR>
nnoremap <buffer> <Plug>(voyager-toggle-hidden) <Cmd>call voyager#mapping#toggle_hidden()<CR>

if get(g:, 'voyager_no_default_keymappings', false)
  finish
endif

if !hasmapto('<Plug>(voyager-open)', 'n')
  nmap <buffer><nowait> <CR> <Plug>(voyager-open)
endif
if !hasmapto('<Plug>(voyager-up)', 'n')
  nmap <buffer><nowait> - <Plug>(voyager-up)
endif
if !hasmapto('<Plug>(voyager-reload)', 'n')
  nmap <buffer><nowait> r <Plug>(voyager-reload)
endif
if !hasmapto('<Plug>(voyager-toggle-hidden)', 'n')
  nmap <buffer><nowait> . <Plug>(voyager-toggle-hidden)
endif
