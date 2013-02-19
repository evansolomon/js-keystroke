# Inspired by https://gist.github.com/1537200
# Requires coffee-script and uglifyjs

fs              = require 'fs'
{ exec, spawn } = require 'child_process'
targetFiles     = ['jquery.keystroke', '_.keystroke']

date   = new Date().toDateString()
banner = """
/*!
 * JS keyStroke
 * Copyright (c) Evan Solomon #{date}
 * Licensed MIT
 */
"""

prependBanner = ( targetFile ) ->
	fs.readFile targetFile, 'utf-8', ( err, code ) ->
		return if err
		fs.writeFile targetFile, "#{banner}\n#{code}"

build = ( file ) ->
	exec "coffee -o lib -c src/#{file}.coffee && uglifyjs lib/#{file}.js -cm -o min/#{file}.min.js", ->
		prependBanner "#{dir}/#{file}.#{ext}" for dir, ext of { lib: 'js', min: 'min.js' }

task 'build', 'compile and minify', ->
	build file for file in targetFiles
