// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.



require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("bootstrap")
require('jquery')
require('datatables.net-bs4')

import { initMapbox } from '../plugins/init_mapbox';
import { initAutocomplete } from '../plugins/init_autocomplete';
import "controllers"

document.addEventListener('turbolinks:load', () => {
  initMapbox();
  initAutocomplete();
})

// For the searchable/sortable table
$(document).ready(function () {
  $('#table-index').DataTable({
    "lengthChange": false,
    "dom": '<"text-left ml-3 searchbar-index"f>',
    "oLanguage": {
       "sSearch": "Filtrer"
     }

  });
  $('.dataTables_length').addClass('bs-select');
});


// For the homepager carousel
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
      for (var j=0; j< it ; j++) {
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


