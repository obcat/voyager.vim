let s:suite = themis#suite('mapping/toggle_hidden')
let s:assert = themis#helper('assert')

function s:suite.before()
  call SetWorkingDirectory()
  call writefile([], '.hiddenA')
  call writefile([], '.hiddenB')
  call writefile([], 'not_hiddenA')
  call writefile([], 'not_hiddenB')
endfunction

function s:suite.toggle_hidden()
  edit .
  call s:assert.equals(getline(1, '$'), [
    \ '.hiddenA',
    \ '.hiddenB',
    \ 'not_hiddenA',
    \ 'not_hiddenB',
    \ ])
  normal .
  call s:assert.equals(getline(1, '$'), [
    \ 'not_hiddenA',
    \ 'not_hiddenB',
    \ ])
endfunction
