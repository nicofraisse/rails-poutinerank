require('jquery');

const initMultiImageCarousel = () => {
  var numberOfCarousels = $('.carousel').length
  for (let i = 0; i < numberOfCarousels; i++) {
    $(`#carousel-example-${i}`).on(`slide.bs.carousel`, function (e) {
      var $e = $(e.relatedTarget);
      var idx = $e.index();
      var itemsPerSlide = 4;
      var totalItems = this.querySelectorAll('.carousel-item').length;
      console.log(idx, itemsPerSlide, totalItems)
      if (idx >= totalItems - (itemsPerSlide - 1)) {
        var it = itemsPerSlide - (totalItems - idx);
        for (var j=0; j < it ; j++) {
          // append slides to end
          if (e.direction == "left") {
            $(`.ci-${i}`).eq(j).appendTo(`.c-${i}`);
          }
          else {
            $(`.ci-${i}`).eq(0).appendTo(`.c-${i}`);
          }
        }
      }
    });
  }
};

export { initMultiImageCarousel };
