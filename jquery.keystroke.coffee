( ( $ ) ->
	$.fn.keyStroke = $.keyStroke = ( requiredKeys, callback, options = {} ) ->
		# Defaults
		options = $.extend
			context        : @
			args           : []
			preventDefault : true
			# e.g. 'altKey', 'ctrlKey', 'metaKey', 'shiftKey'
			modKeys        : []
		, options

		# Cache the document object
		$document = $ document

		# Keep track of pressed keys
		activeKeys = []

		# Keystroke-specific namespace, e.g. JQkeyStroke-67-ctrlKey
		namespace = $.map [ requiredKeys, options.modKeys ], ( item ) ->
			item
		.join '-'

		# Bind key listeners
		$document.on "keydown.JQkeyStroke.JQkeyStroke-#{namespace}", ( event ) ->
			activeKeys.push event.keyCode
			# Uniquify activeKeys
			activeKeys = activeKeys.filter ( item, index, array ) ->
				index == $.inArray item, array

			executeCallback event if checkKeystroke event

		$document.on "keyup.JQkeyStroke.JQkeyStroke-#{namespace}", ( event ) ->
			# Remove this key from activeKeys if it's in there
			index = $.inArray event.keyCode, activeKeys
			activeKeys.splice index, 1 if index > -1

		executeCallback = ( event ) ->
			event.preventDefault() if options.preventDefault
			callback.apply( options.context, [ event ].concat options.args )

		checkKeystroke = ( event )->
			if 'array' == $.type requiredKeys
				# Make sure activeKeys and requiredKeys contain with exactly the same values, regardless of order
				0 == $( activeKeys ).not( requiredKeys ).length == $( requiredKeys ).not( activeKeys ).length
			else
				# Make sure the right number of keys are pressed and our target key is in it
				return false unless 1 + options.modKeys.length == activeKeys.length
				return false unless $.inArray( requiredKeys, activeKeys ) > -1

				# Make sure all of our mod keys are pressed
				# Since we know the target key is pressed and the count of keys is correct, this means
				#   no other mod keys are pressed
				for modifier in options.modKeys
					return false unless event[ modifier ]

				true

		@
) jQuery
