VimSpec = require '../lib/vimspec'
expect = (require 'chai').expect
path = require 'path'

describe "VimSpec", ->
  describe "#run", ->
    it "runs the tests and returns the output", ->
      spec = new VimSpec('test/fixtures')
      output = spec.run()
      expect(output).to.eql {
        "test/fixtures/file_spec.vim": [
          "#TestAdd:",
          "Add(1,2)",
          "✓ equals 3"
          "#TestSubtract:",
          "Subtract(1,2)",
          "☓ expected '2' to equal '-1'"
        ]
      }
      
  describe "#getTestFunctions", ->
    it "search for functions starting with 'Test'", ->
      spec = new VimSpec('test/fixtures')
      functions = spec.getTestFunctions('test/fixtures/file_spec.vim')
      expect(functions).to.eql ['TestAdd', 'TestSubtract']
      
  describe "#getRuntimeFilePath", ->
    it "returns the fullpath to vimspec.vim", ->
      spec = new VimSpec('test/fixtures')
      expect(spec.getRuntimeFilePath()).to.equal \
        path.join(__dirname, '..', 'lib', 'vimspec.vim')
      
  describe "#getTestFiles", ->
    it "returns the test files", ->
      spec = new VimSpec('test/fixtures')
      expect(spec.getTestFiles()).to.eql [
        'test/fixtures/file_spec.vim'
      ]

