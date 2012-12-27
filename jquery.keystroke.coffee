( ( $ ) ->
	$.keyStroke = ( requiredKeys, callback, options = {} ) ->
		# Defaults
		options = $.extend
			context : @
			args    : []
		, options

		# Cache the document object
		$document = $ document

		# Keep track of pressed keys
		activeKeys = []

		# Bind key listeners
		$document.keydown ( event ) ->
			activeKeys.push event.keyCode
			$.unique activeKeys

			callback.apply( options.context, [event].concat options.args ) if checkKeystroke()

		$document.keyup ( event ) ->
			# Remove this key from activeKeys if it's in there
			index = $.inArray event.keyCode, activeKeys
			activeKeys.splice index, 1 if index > -1

		checkKeystroke = ->
			# Make sure activeKeys and requiredKeys have exactly the same values
			0 == $( activeKeys ).not( requiredKeys ).length == $( requiredKeys ).not( activeKeys ).length

) jQuery
