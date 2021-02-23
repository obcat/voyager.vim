let s:suite = themis#suite('mapping/open')
let s:assert = themis#helper('assert')

function s:suite.before()
  call SetWorkingDirectory()
endfunction

function s:suite.open_file()
  call writefile(['This is fileA'], 'fileA')
  edit .
  call s:assert.equals(getline(1, '$'), ['fileA'])
  execute "normal \<CR>"
  call s:assert.equals(getline(1, '$'), ['This is fileA'])
  call s:assert.equals(bufname()->fnamemodify(':t'), 'fileA')
  call delete('fileA')
endfunction

function s:suite.enter_directory()
  call mkdir('dirA')
  call writefile([], 'dirA/fileA')
  edit .
  call s:assert.equals(getline(1, '$'), ['dirA/'])
  execute "normal \<CR>"
  " NOTE: Inside test, BufEnter is not triggered here. Why?
  doautocmd voyager BufEnter
  call s:assert.equals(getline(1, '$'), ['fileA'])
  call delete('dirA', 'rf')
endfunction

function s:suite.try_to_open_missing_file()
  call writefile([], 'fileA')
  edit .
  call s:assert.equals(getline(1, '$'), ['fileA'])
  call delete('fileA')
  call s:assert.equals(getline(1, '$'), ['fileA'])
  execute "normal \<CR>"
  call s:assert.equals(getline(1, '$'), ['fileA'])
  call s:assert.match(execute('1 messages')->substitute("\n", '', ''),
    \ '^\[voyager\] Error: Cannot open "\f\+/fileA".$')
endfunction

function s:suite.try_to_open_message()
  edit .
  call s:assert.equals(getline(1, '$'), ['(no files)'])
  call assert_beeps("normal \<CR>")
  call s:assert.equals(getline(1, '$'), ['(no files)'])
  " TODO: Test for the "(error)" message.
endfunction

function s:suite.open_file_which_name_is_same_as_message()
  for name in ['(no files)', '(error)']
    call writefile([printf('This is %s', name)], name)
    edit .
    call s:assert.equals(getline(1, '$'), [name])
    execute "normal \<CR>"
    call s:assert.equals(getline(1, '$'), [printf('This is %s', name)])
    call s:assert.equals(bufname()->fnamemodify(':t'), name)
    call delete(name)
  endfor
endfunction
