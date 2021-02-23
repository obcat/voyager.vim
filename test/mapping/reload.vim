let s:suite = themis#suite('mapping/reload')
let s:assert = themis#helper('assert')

function s:suite.before()
  call SetWorkingDirectory()
endfunction

function s:suite.after_create()
  edit .
  call s:assert.equals(getline(1, '$'), ['(no files)'])
  call writefile([], '😺.txt')
  call s:assert.equals(getline(1, '$'), ['(no files)'])
  normal r
  call s:assert.equals(getline(1, '$'), ['😺.txt'])
  call delete('😺.txt')
endfunction

function s:suite.after_delete()
  call writefile([], '🐶.txt')
  edit .
  call s:assert.equals(getline(1, '$'), ['🐶.txt'])
  call delete('🐶.txt')
  call s:assert.equals(getline(1, '$'), ['🐶.txt'])
  normal r
  call s:assert.equals(getline(1, '$'), ['(no files)'])
endfunction
