source test/fixtures/file.vim

function! TestAdd()
  call Describe("Add(1,2)")
  call AssertEquals(Add(1,2), 3)
endfunc

function! TestSubtract()
  call Describe("Subtract(1,2)")
  call AssertEquals(Subtract(1,2), -1) 
endfunc

function! TestJoin()
  call Describe("Join(1,2)")
  call AssertEquals(Join(1,2), [1,2])
endfunc
