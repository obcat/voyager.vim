" voyager - Minimal file explorer
" Maintainer: obcat <obcat@icloud.com>
" License:    MIT License

function! voyager#statusline#minimal#statusline() abort
  let s = ''
  let s .= '  "%F" %=%<'
  if empty(getline('.')) || get(b:, 'voyager_error', 0)
    let s .= '? files'
  elseif get(b:, 'voyager_nofiles', 0)
    let s .= 'no files'
  else
    let s .= '%L files'
  endif
  let s .= '  '
  return s
endfunction
