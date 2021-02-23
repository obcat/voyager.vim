let s:suite = themis#suite('sort')
let s:assert = themis#helper('assert')

function s:suite.before()
  call SetWorkingDirectory()
  call mkdir('a1_dir')
  call mkdir('a2_dir')
  call mkdir('b1_dir')
  call mkdir('b2_dir')
  call writefile([], 'a1_file')
  call writefile([], 'a2_file')
  call writefile([], 'b1_file')
  call writefile([], 'b2_file')
endfunction

function s:suite.after()
  unlet g:voyager_sort_maxdepth
endfunction

function s:suite.depth_0()
  let g:voyager_sort_maxdepth = 0
  edit .
  let actuals = getline(1, '$')
  let expects = [
    \ '^[ab][12]_dir/$',
    \ '^[ab][12]_dir/$',
    \ '^[ab][12]_dir/$',
    \ '^[ab][12]_dir/$',
    \ '^[ab][12]_file$',
    \ '^[ab][12]_file$',
    \ '^[ab][12]_file$',
    \ '^[ab][12]_file$',
    \ ]
  call s:assert.equals(len(actuals), len(expects))
  for i in range(len(actuals))
    call s:assert.match(actuals[i], expects[i])
  endfor
endfunction

function s:suite.depth_1()
  let g:voyager_sort_maxdepth = 1
  edit .
  let actuals = getline(1, '$')
  let expects = [
    \ '^a[12]_dir/$',
    \ '^a[12]_dir/$',
    \ '^b[12]_dir/$',
    \ '^b[12]_dir/$',
    \ '^a[12]_file$',
    \ '^a[12]_file$',
    \ '^b[12]_file$',
    \ '^b[12]_file$',
    \ ]
  call s:assert.equals(len(actuals), len(expects))
  for i in range(len(actuals))
    call s:assert.match(actuals[i], expects[i])
  endfor
endfunction

function s:suite.depth_2()
  let g:voyager_sort_maxdepth = 2
  edit .
  call s:assert.equals(getline(1, '$'), [
   \ 'a1_dir/',
   \ 'a2_dir/',
   \ 'b1_dir/',
   \ 'b2_dir/',
   \ 'a1_file',
   \ 'a2_file',
   \ 'b1_file',
   \ 'b2_file',
   \ ])
endfunction
