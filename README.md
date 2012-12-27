# jquery.keyStroke

A very simple jQuery plugin for binding actions to keyboard combinations.

## Usage

`$.keyStroke()` takes two required arguments (`requriedKeys` and `callback`) and a third optional (`options`) argument.

**Required**
* `requiredKeys`: Array of JavaScript keyCodes for your keystroke.  Order is *not* important, and ordered keystrokes are not supported.  [This](http://www.w3.org/2002/09/tests/keys.html) page is helpful for finding keyCodes.
* `callback`: A function to call when your keystroke is executed.

**Options**
* `arguments`: An array of arguments to be passed to your callback when your keystroke is exectuted.  The last `keydown`'s `event` object is always passed as the first argument to `callback`.
* `context`: The value of `this` for your callback.

Options should be passed via an object, e.g. `{arguments: ['foo', 'bar'], context: someValueForThis}`

## Example

```javascript
saveSomething = function( event ) {
	// ...do something with the keydown event that triggered the keystroke
	someSaveAction();
}

// Save something on ctrl + s
// ctrl = 17
// s = 83
$.keyStroke( [17, 83], saveSomething );
```

You can also use anonymous callbacks.

```javascript
$.keyStroke( [17, 83], function() { 'You pressed CTRL + S!'; } );
```

See `/example/index.html` for an example of toggling a request cookie with a keystroke.

## Installation

Load `jquery.keystroke.js` after jQuery.