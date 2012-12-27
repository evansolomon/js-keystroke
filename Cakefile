# Inspired by https://gist.github.com/1537200
# Requires coffee-script and uglifyjs

{ exec, spawn } = require 'child_process'
targetFile      = 'jquery.keyStroke'

task 'compile', 'Compile CoffeeScript file', ->
  exec "coffee -c #{targetFile}.coffee", exerr

task 'min', 'Minify compiled JavaScript file', ->
  exec "uglifyjs #{targetFile}.js -cm -o #{targetFile}.min.js", exerr

task 'build', 'compile and minify', ->
  invoke 'compile'
  invoke 'min'
