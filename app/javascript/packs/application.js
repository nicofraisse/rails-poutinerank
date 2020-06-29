// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.



// require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("bootstrap")
require('jquery')
require('datatables.net-bs4')

import { initMapbox } from '../plugins/init_mapbox';
import { initAutocomplete } from '../plugins/init_autocomplete';
import "controllers"
import { initStarRating } from '../plugins/init_star_rating';

document.addEventListener('turbolinks:load', () => {
  initStarRating();
  initMapbox();
  initAutocomplete();
})

// For the searchable/sortable table
$(document).on('turbolinks:load', function () {
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
$(document).on('turbolinks:load', function () {
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
});

// For updating the review like button
$(document).on('turbolinks:load', function () {
  document.querySelectorAll('.card-review-info-personal').forEach((pack) => {
    var upvoted = false;
    var downvoted = false;
    const upButton = pack.querySelector('#upEnabled-' + pack.dataset.id)
    const downButton = pack.querySelector('#downEnabled-' + pack.dataset.id);
    pack.querySelector('.btn-upvote').addEventListener(('click'), (e) => {
      if (upvoted == false && downvoted == true) {
        pack.querySelector('.no-upvotes').innerHTML = parseInt(pack.querySelector('.no-upvotes').innerHTML) + 2;
        pack.querySelector('.btn-upvote').classList.add('upvoted');
        pack.querySelector('.btn-downvote').classList.remove('downvoted');
        upButton.value = 'trueChangedMyMind'
        downButton.value = 'true';
        upvoted = true;
        downvoted = false;
      } else if (upvoted == false && downvoted == false) {
        pack.querySelector('.no-upvotes').innerHTML++;
        pack.querySelector('.btn-upvote').classList.add('upvoted');
        upButton.value = 'true';
        downButton.value = 'true';
        upvoted = true;
      } else if (upvoted == true && downvoted == false) {
        pack.querySelector('.no-upvotes').innerHTML--;
        pack.querySelector('.btn-upvote').classList.remove('upvoted');
        upButton.value = 'trueSpam';
        downButton.value = 'true';
        upvoted = false;
      }
    })
    pack.querySelector('.btn-downvote').addEventListener(('click'), (e) => {
      if (downvoted == false && upvoted == true) {
        pack.querySelector('.no-upvotes').innerHTML -= 2;
        pack.querySelector('.btn-downvote').classList.add('downvoted');
        pack.querySelector('.btn-upvote').classList.remove('upvoted');
        upButton.value = 'true'
        downButton.value = 'trueChangedMyMind';
        downvoted = true;
        upvoted = false;
      } else if (downvoted == false && upvoted == false) {
        pack.querySelector('.no-upvotes').innerHTML--;
        pack.querySelector('.btn-downvote').classList.add('downvoted');
        upButton.value = 'true'
        downButton.value = 'true';
        downvoted = true;
      } else if (downvoted == true && upvoted == false) {
        pack.querySelector('.no-upvotes').innerHTML++;
        pack.querySelector('.btn-downvote').classList.remove('downvoted');
        upButton.value = 'true'
        downButton.value = 'trueSpam';
        downvoted = false;
      }
    })
  })
});

// For showing less/more words
$(document).on('turbolinks:load', function () {
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
});


