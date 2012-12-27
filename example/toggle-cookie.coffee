( ( $ ) ->
	toggleCookie = ->
		name = 'toggleableCookie'
		if $.cookie name
			$.removeCookie name
		else
			$.cookie name, 1

		status = if $.cookie name then "have" else "don't have"
		$( 'body' ).append "<p>Now you <strong>#{status}</strong> the cookie</p>"


	# Bind to ready
	$ ->
		# ctrl + c
		$.keyStroke 67, toggleCookie,
			modKeys: [ 'ctrlKey' ]
) jQuery