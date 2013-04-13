execSync = require('execSync').stdout
fs = require 'fs'
path = require 'path'
clc = require 'cli-color'
_ = require 'lodash'

module.exports = class VimSpec
  constructor: (@path) ->

  run: ->
    output = {}
    for testfile in @getTestFiles()
      output[testfile] = @testFile(testfile)
    output
    
  testFile: (fullpath) ->
    fs.unlinkSync('vimspec.output') if fs.existsSync('vimspec.output')
    fs.unlinkSync('vimspec.errors') if fs.existsSync('vimspec.errors')
    functions = @getTestFunctions(fullpath)
    cmd = "vim -V0vimspec.errors -e '+source #{@getRuntimeFilePath()}' " +
      "'+call Test(\"#{fullpath}\", #{JSON.stringify(functions)})' " +
      "+qall!"
    execSync cmd
    output = []
    if fs.existsSync('vimspec.output')
      output = fs.readFileSync('vimspec.output', 'utf-8').trim().split("\n")
    if fs.existsSync('vimspec.errors')
      errors = fs.readFileSync('vimspec.errors', 'utf-8')
      if /error/i.test(errors)
        output.push errors
    fs.unlinkSync('vimspec.output') if fs.existsSync('vimspec.output')
    fs.unlinkSync('vimspec.errors') if fs.existsSync('vimspec.errors')
    output

    
  getTestFunctions: (fullpath) ->
    functions = []
    for line in fs.readFileSync(fullpath, 'utf-8').split("\n")
      match = /fun(c|ct|cti|ctio|ction)!? (Test[^ (]+)/.exec(line)
      if match?
        functions.push match[2]
    functions
    
  getRuntimeFilePath: ->
    path.join(__dirname, 'vimspec.vim')
    
  getTestFiles: ->
    files = []
    for file in fs.readdirSync(@path)
      if /_(test|spec).vim$/.test(file)
        files.push path.join(@path, file)
    files
        
