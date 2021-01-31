" voyager - Minimal file explorer
" Maintainer: obcat <obcat@icloud.com>
" License:    MIT License

if exists('b:did_ftplugin')
  finish
endif

nnoremap <buffer> <silent> <Plug>(voyager-open)          :<C-u>call voyager#open()<CR>
nnoremap <buffer> <silent> <Plug>(voyager-up)            :<C-u>call voyager#up()<CR>
nnoremap <buffer> <silent> <Plug>(voyager-home)          :<C-u>call voyager#home()<CR>
nnoremap <buffer> <silent> <Plug>(voyager-reload)        :<C-u>call voyager#reload()<CR>
nnoremap <buffer> <silent> <Plug>(voyager-toggle-hidden) :<C-u>call voyager#toggle_hidden()<CR>

if !get(g:, 'voyager_no_default_keymappings', 0)
  if !hasmapto('<Plug>(voyager-open)', 'n')
    nmap <buffer> <nowait> <CR> <Plug>(voyager-open)
  endif
  if !hasmapto('<Plug>(voyager-up)', 'n')
    nmap <buffer> <nowait> - <Plug>(voyager-up)
  endif
  if !hasmapto('<Plug>(voyager-home)', 'n')
    nmap <buffer> <nowait> ~ <Plug>(voyager-home)
  endif
  if !hasmapto('<Plug>(voyager-reload)', 'n')
    nmap <buffer> <nowait> \\ <Plug>(voyager-reload)
  endif
  if !hasmapto('<Plug>(voyager-toggle-hidden)', 'n')
    nmap <buffer> <nowait> + <Plug>(voyager-toggle-hidden)
  endif
endif

let b:did_ftplugin = 1
