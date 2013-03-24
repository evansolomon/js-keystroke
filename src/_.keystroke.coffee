# # Underscore keyStroke
# ----------------------

# Bind to the `_` namespace
_.mixin
	keyStroke: ( requiredKeys, callback, options = {} ) ->

		# ### Options
		# -----------

		# * `context`: The value of `this` for your callback.
		# * `args`: An array of arguments to be passed to your callback when your keystroke is
		#     exectuted. The last `keydown`'s event object is always passed as the first argument to
		#     `callback`. (*Note: this has nothing to do with JavaScript's `arguments` object.*)
		# * `preventDefault`: Whether or not to `preventDefault()` on the `keydown` event that
		#     triggers your keystroke. Defaults to `true`.
		# * `modKeys`: Array of strings that match `keydown` event properties and can be used to
		#     include modifier keys in your keystroke.  The `modKeys` option is only used if
		#     `requiredKeys` is a single (non-array) value, otherwise it is ignored.
		#     Examples: `'altKey'`, `'ctrlKey'`, `'metaKey'`, `'shiftKey'`
		options = _.defaults options,
			context        : @
			args           : []
			preventDefault : true
			modKeys        : []


		# ### Setup reusable values
		# -------------------------

		# Keep track of pressed keys
		# A keystroke is internally treated as a group of pressed keys and compared against this array
		activeKeys = []

		# IE compatability
		# Old versions of IE use `attachEvent` instead of `addEventListener`
		# Internally we'll use `eventMethod` to bind events
		eventMethod = if document.addEventListener then 'addEventListener' else 'attachEvent'


		# ### Key listeners
		# -----------------

		# Bind `keydown` listener to `document`
		document[ eventMethod ] 'keydown', ( event ) ->

			# When a key is pressed, add its `keyCode` to the `activeKeys` list
			# Then remove duplicate entries in the `activeKeys` list, just in case
			activeKeys = _.union activeKeys, event.key || event.keyCode || event.which
			executeCallback event if checkKeystroke event

		# Bind `keyup` listener to `document`
		# Removes keys from `activeKeys` when they are released
		document[ eventMethod ] 'keyup', ( event ) ->
			activeKeys = _.without activeKeys, event.key || event.keyCode || event.which


		# ### Activated keystroke helpers
		# -------------------------------

		# Generic wrapper to execute the `callback` passed to `$.keyStroke`
		#
		# Takes an `event` object, which will always be the event that triggered the keystroke
		executeCallback = ( event ) ->
			# If the `preventDefault` option was not disabled, prevent it on the keystroke's `event`
			#
			# This is useful for keystroke's that might conflict with other browser behavior
			#
			# For example: CMD + S, which might otherwise trigger the browser's save function
			event.preventDefault() if options.preventDefault

			# Run the callback
			#
			# Uses the `context` option if one is present, otherwise uses the context at the time
			#   that `keyStroke()` was called
			#
			# Flattens the `event` object and any `args` passed in options into arguments
			#   for the callback
			callback.apply( options.context, [ event ].concat options.args )

		# Generic wrapper to check whether or not the keystroke has been activated
		checkKeystroke = ( event )->
			# If `requiredKeys` is an array, use Underscore's `difference()` to compare
			#   it to `activeKeys`
			if _.isArray requiredKeys
				[] == _.difference activeKeys, requiredKeys

			# If `requiredKeys` is a single keycode, check that key and the `modKeys` option
			else
				requiredKey = requiredKeys

				# Make sure the right number of keys are pressed and our target key is in it
				return false unless 1 + options.modKeys.length == activeKeys.length
				return false unless _.contains activeKeys, requiredKey

				# Make sure all modKeys are pressed
				_.every _.map( options.modKeys, ( key ) ->
					event[ key ]
				), _.identity
