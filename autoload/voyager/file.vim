" voyager - Minimal file explorer
" Maintainer: obcat <obcat@icloud.com>
" License:    MIT License

" Returns a list of file names in specified directory.
function voyager#file#get_filenames(dir) abort
  let show_hidden = get(b:, 'voyager_show_hidden',
    \               get(g:, 'voyager_show_hidden',
    \ 1))
  let Filter = show_hidden ? 1 : {file -> file.name !~ '^\.'}
  let files = readdirex(a:dir, Filter, {'sort': 'none'})
  call s:add_metadata(files)
  call sort(files, 's:compare')
  return map(files, 'v:val.name . (v:val.isdir ? "/" : "")')
endfunction

" Add new entry with "isidir" key. The value is:
"   * 1 if specified file is directory or symlink to directory,
"   * 0 if not.
function s:add_metadata(files) abort
  for file in a:files
    let file.isdir = file.type is# 'dir' || file.type is# 'linkd'
  endfor
endfunction

function s:compare(file1, file2) abort
  let f1 = a:file1
  let f2 = a:file2
  if f1.isdir != f2.isdir
    " Directory first
    return f1.isdir ? -1 : +1
  endif
  let n1 = f1.name
  let n2 = f2.name
  let l1 = len(n1)
  let l2 = len(n2)
  let maxdepth = get(g:, 'voyager_sort_maxdepth', 99)
  for i in range(0, min([l1, l2, maxdepth]) - 1)
    if n1[i] is# n2[i]
      continue
    endif
    " Dictionary order
    return n1[i] < n2[i] ? -1 : +1
  endfor
  " Shorter first
  return l1 < l2 ? -1 : +1
endfunction
