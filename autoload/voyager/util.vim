vim9script
# voyager - Minimal file explorer
# Maintainer: obcat <obcat@icloud.com>
# License:    MIT License

def voyager#util#echoerr(...msgs: list<string>)
  echohl ErrorMsg
  for msg in msgs
    echomsg printf('[voyager] %s', msg)
  endfor
  echohl None
enddef

def voyager#util#beep()
  execute 'normal! "\<ESC>"'
enddef
