require('jquery');

const initViewMore = () => {
  $.fn.clicktoggle = function(a, b) {
    return this.each(function() {
      var clicked = false;
      $(this).click(function() {
        if (clicked) {
          clicked = false;
          return b.apply(this, arguments);
        }
        clicked = true;
        return a.apply(this, arguments);
      });
    });
  };
  $(".more").clicktoggle(function() {
    $(this).text("less..").siblings(".complete").show();
  }, function() {
    $(this).text("more..").siblings(".complete").hide();
  });
};

export { initViewMore };
