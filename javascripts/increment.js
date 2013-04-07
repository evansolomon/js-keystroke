(function() {
	var counter;

	counter = {
		change: function( diff ) {
			var el, number;

			el = document.getElementById('counter');
			number = parseInt( el.innerText, 10 );
			return el.innerHTML = number + diff;
		},

		increment: function() {
			return counter.change( 1 );
		},

		decrement: function() {
			return counter.change( -1 );
		}
	};

	// 68 = D
	_.keyStroke( 68, { modKeys: [ 'shiftKey' ] }, counter.decrement );
	// 73 = I
	_.keyStroke( 73, { modKeys: [ 'shiftKey' ] }, counter.increment );
}).call();
