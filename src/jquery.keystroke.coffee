# # jQuery keyStroke
# ------------------

# Bind to the $ namespace in the plugin's scope
( ( $ ) ->

  # Make keyStroke chainable *and* independently accessible
  $.fn.keyStroke = $.keyStroke = ( requiredKeys, options, callback ) ->

    # ### Optional argument
    # ---------------------

    # Make `options` argument optional but keep `callback` as the last argument.
    if arguments.length is 2
      callback = options
      options = {}


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
    options = $.extend
      context        : @
      args           : []
      preventDefault : true
      modKeys        : []
    , options


    # ### Setup reusable values
    # -------------------------

    # Cache the document's jQuery object so that we can reuse it
    $document = $ document

    # Keep track of pressed keys
    #
    # A keystroke is internally treated as a group of pressed keys and compared against this array
    activeKeys = []

    # Create a keystroke-specific namespace so that individual keystroke combinations can be unbound
    # For example: `JQkeyStroke-67-ctrlKey`
    #
    # Unbinding could be done with: `$(document).off('JQkeyStroke-67-ctrlKey')`
    namespace = $.map [ requiredKeys, options.modKeys ], ( item ) ->
      item
    .join '-'


    # ### Key listeners
    # -----------------

    # Bind `keydown` listener to `$(document)`
    #
    # Events are bound both to the keystroke-specific namespace and a generic `JQkeyStroke` namespace
    $document.on "keydown.JQkeyStroke.JQkeyStroke-#{namespace}", ( event ) ->

      # When a key is pressed, add its `keyCode` to the `activeKeys` list
      # Then remove duplicate entries in the `activeKeys` list, just in case
      activeKeys.push event.keyCode
      activeKeys = activeKeys.filter ( item, index, array ) ->
        index == $.inArray item, array

      # If the keystroke is activated, run the callback
      executeCallback event if checkKeystroke event

    # Bind `keyup` listener to `$(document)`
    #
    # Removes keys from `activeKeys` when they are released
    $document.on "keyup.JQkeyStroke.JQkeyStroke-#{namespace}", ( event ) ->
      index = $.inArray event.keyCode, activeKeys
      activeKeys.splice index, 1 if index > -1

    # When the window regains focus we have no way to tell what keys
    # might be pressed, so clear our queue
    $( window ).on 'focus', ->
      activeKeys = []


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
      if 'array' == $.type requiredKeys

        # Make sure activeKeys and requiredKeys contain with exactly the same values, regardless of order
        0 == $( activeKeys ).not( requiredKeys ).length == $( requiredKeys ).not( activeKeys ).length

      else

        # Make sure the right number of keys are pressed and our target key is in it
        return false unless 1 + options.modKeys.length == activeKeys.length
        return false unless $.inArray( requiredKeys, activeKeys ) > -1

        # Make sure all of our mod keys are pressed
        #
        # Since we know the target key is pressed and the count of keys is correct, this means
        #   no other mod keys are pressed
        for modifier in options.modKeys
          return false unless event[ modifier ]

        return true


    # ### jQuery
    # ----------

    # Return the current context
    #
    # This is used to make `keyStroke` chainable
    return this

# Pass in the global `jQuery`
) jQuery
