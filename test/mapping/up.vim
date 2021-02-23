let s:suite = themis#suite('mapping/up')
let s:assert = themis#helper('assert')

function s:suite.before()
  call SetWorkingDirectory()
endfunction

function s:suite.up()
  call mkdir('parent_dir/child_dir', 'p')
  edit parent_dir/child_dir
  call s:assert.equals(getline(1, '$'), ['(no files)'])
  normal -
  call s:assert.equals(getline(1, '$'), ['child_dir/'])
  call delete('parent_dir', 'rf')
endfunction

function s:suite.focus_on_previous_directory()
  call mkdir('parent_dir')
  call mkdir('parent_dir/child_dir1')
  call mkdir('parent_dir/child_dir2')
  call mkdir('parent_dir/child_dir3')
  for cdir in ['child_dir1', 'child_dir2', 'child_dir3']
    execute 'edit' fnameescape(printf('parent_dir/%s', cdir))
    call s:assert.equals(getline(1, '$'), ['(no files)'])
    normal -
    call s:assert.equals(getline('.'), printf('%s/', cdir))
  endfor
  call delete('parent_dir', 'rf')
endfunction

function s:suite.try_to_go_up_root_directory()
  edit /
  " NOTE: Inside test, BufEnter is not triggered here. Why?
  doautocmd voyager BufEnter
  call s:assert.equals(&filetype, 'voyager')
  let files = getline(1, '$')
  call assert_beeps('normal -')
  call s:assert.equals(getline(1, '$'), files)
endfunction
