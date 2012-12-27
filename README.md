# jquery.keystroke

A very simple jQuery plugin for binding actions to keyboard combinations.

## Usage

`$.keyStroke()` takes two required arguments and a third optional `options` argument.

**Required**
* `requiredKeys`: Array of JavaScript keyCodes for your keystroke.  Order is *not* important, and ordered keystrokes are not supported.  [This](http://www.w3.org/2002/09/tests/keys.html) page is helpful for finding keyCodes.
* `callback`: A function to call when your keystroke is executed.

**Options**
* `arguments`: An array of arguments to be passed to your callback when your keystroke is exectuted.
* `context`: The value of `this` for your callback.

Options should be passed via an object, e.g. `{arguments: ['foo', 'bar'], context: someValueForThis}`

## Example

```javascript
saveSomething = function() {
	// ...maybe some other code
	someSaveAction();
}

// Save something on ctrl + s
// ctrl = 17
// s = 83
$.keyStroke( [17, 83], saveSomething );
```

## Installation

Load `jquery.keystroke.js` after jQuery.