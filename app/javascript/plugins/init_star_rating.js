import "jquery-bar-rating";

const initStarRating = () => {
  $('#review_global_rating').barrating({
    theme: 'bars-1to10'
  });
  $('#review_fries_rating').barrating({
    theme: 'css-stars'
  });
  $('#review_cheese_rating').barrating({
    theme: 'css-stars'
  });
  $('#review_sauce_rating').barrating({
    theme: 'css-stars'
  });
  $('#review_service_rating').barrating({
    theme: 'css-stars'
  });
};

export { initStarRating };
