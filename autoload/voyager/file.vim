vim9script
# voyager - Minimal file explorer
# Maintainer: obcat <obcat@icloud.com>
# License:    MIT License

def voyager#file#get_filenames(dir: string): list<string>
  const show_hidden = get(b:, 'voyager_show_hidden',
                      get(g:, 'voyager_show_hidden', true))
  const Filter = (file) => show_hidden ?? file.name !~ '^\.'
  final files = readdirex(dir, Filter, {sort: 'none'})
  AddMetadata(files)
  sort(files, Compare)
  return files->mapnew((_, file) => file.name .. (file.isdir ? '/' : ''))
enddef


# Add a new entry with "isidir" key to each file info. The value is true if
# the file is a directory or a symbolic link to a directory, false otherwise.
def AddMetadata(files: list<dict<any>>)
  for file in files
    file.isdir = file.type is 'dir' || file.type is 'linkd'
  endfor
enddef

def Compare(f1: dict<any>, f2: dict<any>): number
  if f1.isdir != f2.isdir
    # Directory first
    return f1.isdir ? -1 : +1
  endif
  const n1 = f1.name
  const n2 = f2.name
  const l1 = len(n1)
  const l2 = len(n2)
  const maxdepth = get(g:, 'voyager_sort_maxdepth', 99)
  for i in range(0, min([l1, l2, maxdepth]) - 1)
    if n1[i] is n2[i]
      continue
    endif
    # Dictionary order {{{
    # NOTE: When comparing two strings with "<" or ">", this is done with
    #       strcmp() or stricmp() internally. See ":h expr-<". }}}
    return n1[i] < n2[i] ? -1 : +1
  endfor
  # Shorter first
  return l1 < l2 ? -1 : +1
enddef
