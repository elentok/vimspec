function! StartTest()
  new
  setlocal buftype=nofile
  setlocal noswapfile
  file TestOutput
endfunc

function! Test(fullpath, functions)
  call StartTest()
  exec "source " . a:fullpath
  for funcName in a:functions
    call s:Log("#" . funcName . ":")
    exec "call " . funcName . "()"
  endfor
  call EndTest()
endfunc

function! Describe(text)
  call s:Log(a:text)
endfunc

function! s:Log(text)
  buffer TestOutput
  exec "normal o" . a:text
endfunc

function! EndTest()
  buffer TestOutput
  write vimspec.output
endfunc

function! AssertEquals(value1, value2)
  let value1 = Format(a:value1)
  let value2 = Format(a:value2)
  if a:value1 == a:value2
    exec "normal o" . "✓ equals " . value1
  else
    exec "normal o". "☓ expected '" . value1 . "' to equal '" . value2 . "'"
  end
endfunc

function! Format(value)
  if type(a:value) == type([])
    return "[" . join(a:value, ',') . "]"
  else
    return a:value
  endif
endfunc
