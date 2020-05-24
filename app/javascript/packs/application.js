// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require turbolinks

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("bootstrap")

import { initMapbox } from '../plugins/init_mapbox';

document.addEventListener('turbolinks:load', () => {
  initMapbox();
})

/*
    Carousel
*/

const numberOfCarousels = $('.carousel').length
document.addEventListener('click', () => {
  console.log('hi')
})

for (let i = 0; i < numberOfCarousels; i++) {
  $(`#carousel-example-${i}`).on(`slide.bs.carousel`, function (e) {
    var $e = $(e.relatedTarget);
    var idx = $e.index();
    var itemsPerSlide = 4;
    var totalItems = this.querySelectorAll('.carousel-item').length;

    console.log(idx, itemsPerSlide, totalItems)
    if (idx >= totalItems-(itemsPerSlide-1)) {
      var it = itemsPerSlide - (totalItems - idx);
      for (var j=0; j<it; j++) {
        // append slides to end
        if (e.direction == "left") {
          $(`.ci-${i}`).eq(j).appendTo(`.c-${i}`);
          console.log($(`.ci-${i}`).eq(j))
        }
        else {
          $(`.ci-${i}`).eq(0).appendTo(`.c-${i}`);
        }
      }
    }
  });
}


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


import "controllers"
