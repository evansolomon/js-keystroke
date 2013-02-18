# Inspired by https://gist.github.com/1537200
# Requires coffee-script and uglifyjs

{ exec, spawn } = require 'child_process'
targetFiles     = ['jquery.keystroke', '_.keystroke']

build = ( file ) ->
	exec "coffee -c #{file}.coffee && uglifyjs #{file}.js -cm -o #{file}.min.js"

task 'build', 'compile and minify', ->
	build file for file in targetFiles
