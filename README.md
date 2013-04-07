# JS keyStroke

A jQuery plugin and Underscore mixin for binding actions to keyboard combinations.

## Usage

`$.keyStroke()` and `_.keyStroke()` take three arguments: `requriedKeys`, `options`, and `callback`. The `options` argument is optional. The last argument you pass will **always** be treated as the callback, so to exclude the optional argument you can just pass two.

```javascript
// No options passed
$.keyStroke( [68, 70], function(){ console.log( 'Hello World' ); });

// Options included
$.keyStroke( 83, { modKeys: ['shiftKey'] }, function(){ console.log( 'Hello dog' ); });
```

**Required**
* `requiredKeys`: Array of JavaScript keyCodes for your keystroke.  Can be an integer (rather than an array) if you only want to use one keyCode, not including modifier keys passed in the `options` argument.  Order is *not* important, and ordered keystrokes are not supported.  [This](http://www.w3.org/2002/09/tests/keys.html) page is helpful for finding keyCodes.
* `callback`: A function to call when your keystroke is executed.

**Options**
* `args`: An array of arguments to be passed to your callback when your keystroke is exectuted.  The last `keydown`'s `event` object is always passed as the first argument to `callback`. Note: this has *nothing* to do with JavaScript's `arguments` object.
* `context`: The value of `this` for your callback.
* `preventDefault`: Whether or not to `preventDefault()` on the `keydown` event that triggers your keystroke. Defaults to `true`.
* `modKeys`: Array of strings that match `keydown` event properties and can be used to include modifier keys in your keystroke.  The `modKeys` option is only used if `requiredKeys` is a single (non-array) value, otherwise it is ignored.  Examples: `'altKey'`, `'ctrlKey'`, `'metaKey'`, `'shiftKey'`

Options should be passed via an object, e.g. `{args: ['foo', 'bar'], context: someValueForThis, modKeys: ['altKey']}`

## Example

```javascript
saveSomething = function( event ) {
	// ...do something with the keydown event that triggered the keystroke
	someSaveAction();
}

// Save something on ctrl + s
// s = 83
$.keyStroke( 83, { modKeys: [ 'ctrlKey' ] }, saveSomething );

// Do the same thing with Underscore instead of jQuery
_.keyStroke( 83, { modKeys: [ 'ctrlKey' ] }, saveSomething );
```

You can also use anonymous callbacks.

```javascript
$.keyStroke( 83, { modKeys: [ 'altKey' ] }, function() { 'You pressed ALT + S!'; } );
```

See http://evansolomon.github.com/js-keystroke/ for an example of altering the DOM with a keystroke.

## Installation

Load `jquery.keystroke.js` after jQuery, or `_.keystroke.js` after Underscore.  Both plugins come with a matching `min.js` version.
