class RestaurantsController < ApplicationController
  skip_after_action :verify_policy_scoped, :only => [:index, :show, :search]
  skip_before_action :authenticate_user!, :only => [:index, :show, :search]

  def index
    if params[:query].present?
      @restaurants = Restaurant.global_search(params[:query])
    else
      @restaurants = Restaurant.all
    end

    @restaurants_sorted = @restaurants.sort_by{|restaurant| restaurant.reviews.map{ |r| zero_if_nan(r.global_rating) + zero_if_nan(r.fries_rating) + zero_if_nan(r.cheese_rating) + zero_if_nan(r.sauce_rating) + zero_if_nan(r.service_rating) }.sum / (restaurant.reviews.blank? ? 1 : restaurant.reviews.count) }.reverse

    respond_to do |format|
      format.html
      format.json { render json: { restaurants: @restaurants } }
    end

    @markers = @restaurants.map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude,
        infoWindow: render_to_string(partial: "restaurants/info_window", locals: { restaurant: restaurant })
      }
    end
  end

  def search
    Restaurant.reindex
    query = params[:query].presence || '*'

    p1 = params[:p1].present? ? [0, 6] : nil
    p2 = params[:p2].present? ? [6, 9] : nil
    p3 = params[:p3].present? ? [9, 1000] : nil
    range_creator = [p1, p2, p3].select{ |list| list != nil }.flatten
    range = range_creator.min()..range_creator.max()
    conditions = {
      poutine_price: range
    }

    @restaurants = Restaurant.search query, where: conditions
    authorize @restaurants
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
    @review = Review.new
    @reviews = @restaurant.reviews.sort_by{|r| r.upvotes}.reverse if @restaurant.reviews
    @restaurant_global_rating = (@restaurant.reviews.map{|r| r.global_rating}.sum / @restaurant.reviews.count.to_f).round(1) if @restaurant.reviews
    @markers = [@restaurant].map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude,
        infoWindow: render_to_string(partial: "restaurants/info_window", locals: { restaurant: restaurant })
      }
    end
    respond_to do |format|
      format.html
      format.json { render json: { upvotes: @restaurant.reviews.first.upvotes } }
    end

    if @restaurant.poutine_price < 6
      @price_symbol = '$'
    elsif @restaurant.poutine_price < 10
      @price_symbol = '$$'
    else
      @price_symbol = '$$$'
    end

    unless @restaurant.json_address.nil?
      if @restaurant.json_address['data']['address']['city'].nil?
        @restaurant_city = @restaurant.json_address['data']['address']['municipality']
      else
        @restaurant_city = @restaurant.json_address['data']['address']['city']
      end
    end
  end

  def new
    @restaurant = Restaurant.new
    authorize @restaurant
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    authorize @restaurant
    @restaurant.json_address =  Geocoder.search(@restaurant.address).first
    @restaurant.user = current_user
    if @restaurant.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
    @restaurant.json_address = Geocoder.search(restaurant_address_params['address']).first if @restaurant.json_address.nil?
    @restaurant.save
    @restaurant.update(restaurant_params)
    redirect_to restaurant_path(@restaurant)
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
    @restaurant.destroy
    redirect_to root_path
  end

  private

  def restaurant_address_params
    params.require(:restaurant).permit(:address)
  end

  def restaurant_params
    params.require(:restaurant).permit(:restaurant_id, :name, :category, :address, :poutine_price, :photo, :restaurant_category_id)
  end

  def zero_if_nan(x)
    x.class == Integer || x.class == Float ? x : 0
  end

  def search_params
    params.require(:restaurant).permit(:name)
  end

  helper_method :zero_if_nan
end
