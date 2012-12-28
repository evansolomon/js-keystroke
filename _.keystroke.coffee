_.mixin
	keyStroke: ( requiredKeys, callback, options = {} ) ->
		# Defaults
		options = _.defaults options,
			context        : @
			args           : []
			preventDefault : true
			# e.g. 'altKey', 'ctrlKey', 'metaKey', 'shiftKey'
			modKeys        : []

		# Keep track of pressed keys
		activeKeys = []

		# IE compat
		eventMethod = if document.addEventListener then 'addEventListener' else 'attachEvent'

		# Bind key listeners
		document[ eventMethod ] 'keydown', ( event ) ->
			activeKeys = _.union activeKeys, event.key || event.keyCode || event.which
			executeCallback event if checkKeystroke event

		document[ eventMethod ] 'keyup', ( event ) ->
			activeKeys = _.without activeKeys, event.key || event.keyCode || event.which

		executeCallback = ( event ) ->
			event.preventDefault() if options.preventDefault
			callback.apply( options.context, [ event ].concat options.args )

		checkKeystroke = ( event )->
			if _.isArray requiredKeys
				[] == _.difference activeKeys, requiredKeys
			else
				requiredKey = requiredKeys
				# Make sure the right number of keys are pressed and our target key is in it
				return false unless 1 + options.modKeys.length == activeKeys.length
				return false unless _.contains activeKeys, requiredKey

				# Make sure all modKeys are pressed
				_.every _.map( options.modKeys, ( key ) ->
					event[ key ]
				), _.identity
