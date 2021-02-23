let s:suite = themis#suite('focus_on_altfile')
let s:assert = themis#helper('assert')

function s:suite.before()
  call SetWorkingDirectory()
  call writefile([], 'cat.txt')
  call writefile([], 'dog.txt')
  call writefile([], 'ネコ.txt')
  call writefile([], 'イヌ.txt')
  call writefile([], '*.txt')
  call writefile([], '?.txt')
endfunction

function s:suite.ascii()
  edit cat.txt
  edit .
  call s:assert.equals(getline('.'), 'cat.txt')
  edit dog.txt
  edit .
  call s:assert.equals(getline('.'), 'dog.txt')
endfunction

function s:suite.multibyte()
  edit ネコ.txt
  edit .
  call s:assert.equals(getline('.'), 'ネコ.txt')
  edit イヌ.txt
  edit .
  call s:assert.equals(getline('.'), 'イヌ.txt')
endfunction

function s:suite.special()
  edit \*.txt
  edit .
  call s:assert.equals(getline('.'), '*.txt')
  edit \?.txt
  edit .
  call s:assert.equals(getline('.'), '?.txt')
endfunction
