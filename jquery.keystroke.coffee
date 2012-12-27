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
			# Uniquify activeKeys
			activeKeys = activeKeys.filter ( item, index, array ) ->
		    index == $.inArray item, array

			callback.apply( options.context, options.args ) if checkKeystroke()

		$document.keyup ( event ) ->
			# Remove this key from activeKeys if its in there
			index = $.inArray event.keyCode, activeKeys
			activeKeys.splice index, 1 if index > -1

		checkKeystroke = ->
			# Make sure activeKeys and requiredKeys have exactly the same values
			$( activeKeys ).not( requiredKeys ).length == 0 and $( requiredKeys ).not( activeKeys ).length == 0

) jQuery