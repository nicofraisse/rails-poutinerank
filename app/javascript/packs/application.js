// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require turbolinks

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
require("bootstrap")
require("turbolinks").start()

import { initMapbox } from '../plugins/init_mapbox';
import { initAutocomplete } from '../plugins/init_autocomplete';
import "controllers"

document.addEventListener('turbolinks:load', () => {
  initMapbox();
  initAutocomplete();
})



