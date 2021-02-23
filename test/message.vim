let s:suite = themis#suite('message')
let s:assert = themis#helper('assert')

function s:suite.before()
  call SetWorkingDirectory()
endfunction

function s:suite.nofile()
  edit .
  call s:assert.equals(getline(1, '$'), ['(no files)'])
endfunction

" TODO
" function s:suite.test_error()
"   ...
"   call s:assert.equals(getline(1, '$'), ['(error)'])
" endfunction
