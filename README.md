VimSpec
=======

[![Build Status](https://travis-ci.org/elentok/vimspec.png?branch=master)](https://travis-ci.org/elentok/vimspec)

Vim spec/test framework.

Currently, the only supported assertion is "AssertEquals"
but I'm planning to add more in the future.

Installation
-------------

```
npm install -g vimspec
```

Example usage
--------------

In your plugin, create a test directory with files that end with '_test.vim' or '_spec.vim'.

A spec file looks like this:

```vim
source test/fixtures/file.vim

function! TestAdd()
  call Describe("Add(1,2)")
  call AssertEquals(Add(1,2), 3)
endfunc

function! TestSubtract()
  call Describe("Subtract(1,2)")
  call AssertEquals(Subtract(1,2), -1) 
endfunc
```

Within the plugin's root directory run "vimspec", you will see this output (with colors):

```
test/fixtures/file_spec.vim
  #TestAdd:
    Add(1,2)
      ✓ equals 3
  #TestSubtract:
    Subtract(1,2)
      ☓ expected '2' to equal '-1'

```

