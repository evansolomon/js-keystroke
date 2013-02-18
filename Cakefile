# Inspired by https://gist.github.com/1537200
# Requires coffee-script and uglifyjs

{ exec, spawn } = require 'child_process'
targetFiles     = ['jquery.keystroke', '_.keystroke']

build = ( file ) ->
	exec "coffee -o lib -c src/#{file}.coffee && uglifyjs lib/#{file}.js -cm -o min/#{file}.min.js"

task 'build', 'compile and minify', ->
	build file for file in targetFiles
