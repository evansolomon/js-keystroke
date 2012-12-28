# Inspired by https://gist.github.com/1537200
# Requires coffee-script and uglifyjs

{ exec, spawn } = require 'child_process'
targetFiles     = ['jquery.keystroke', '_.keystroke']

# deal with errors from child processes
exerr  = (err, sout,  serr)->
	process.stdout.write err  if err
	process.stdout.write sout if sout
	process.stdout.write serr if serr

task 'compile', 'Compile CoffeeScript file', ->
	exec "coffee -c #{file}.coffee", exerr for file in targetFiles

task 'min', 'Minify compiled JavaScript file', ->
	exec "uglifyjs #{file}.js -cm -o #{file}.min.js", exerr for file in targetFiles

task 'build', 'compile and minify', ->
	invoke 'compile'
	invoke 'min'
