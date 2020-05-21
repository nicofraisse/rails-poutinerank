class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    if params[:query].present?
      @restaurants = Restaurant.global_search(params[:query])
    else
      @restaurants = Restaurant.all
    end

    @markers = @restaurants.map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude,
        infoWindow: render_to_string(partial: "restaurants/info_window", locals: { restaurant: restaurant })
      }
    end
  end
end

