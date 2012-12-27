// Generated by CoffeeScript 1.4.0
(function() {

  (function($) {
    var toggleCookie;
    toggleCookie = function() {
      var name, status;
      name = 'toggleableCookie';
      if ($.cookie(name)) {
        $.removeCookie(name);
      } else {
        $.cookie(name, 1);
      }
      status = $.cookie(name) ? "have" : "don't have";
      return $('body').append("<p>Now you <strong>" + status + "</strong> the cookie</p>");
    };
    return $(function() {
      return $.keyStroke([17, 67], toggleCookie);
    });
  })(jQuery);

}).call(this);
