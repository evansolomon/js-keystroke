# Inspired by https://gist.github.com/1537200
# Requires coffee-script and uglifyjs

{ exec, spawn } = require 'child_process'
targetFiles     = ['jquery.keystroke', '_.keystroke']

task 'build', 'compile and minify', ->
	exec "coffee -c #{file}.coffee && uglifyjs #{file}.js -cm -o #{file}.min.js" for file in targetFiles
