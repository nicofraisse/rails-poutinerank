// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.



// require("@rails/ujs").start()
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
require("bootstrap");
require('jquery');

import "controllers"
import { initMapbox } from '../plugins/init_mapbox';
import { initAutocomplete } from '../plugins/init_autocomplete';
import { initStarRating } from '../plugins/init_star_rating';
import { initTableSearch } from '../plugins/init_table_search';
import { initMultiImageCarousel } from '../plugins/init_multi_image_carousel';
import { initReviewUpvotes } from '../plugins/init_review_upvotes';
import { initViewMore } from '../plugins/init_view_more';

document.addEventListener('turbolinks:load', () => {
  initStarRating();
  initMapbox();
  initAutocomplete();
  initTableSearch();
  initMultiImageCarousel();
  initReviewUpvotes();
  initViewMore();
});


