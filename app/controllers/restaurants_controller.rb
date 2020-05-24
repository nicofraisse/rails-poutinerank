class RestaurantsController < ApplicationController
  skip_after_action :verify_policy_scoped, :only => [:index, :show]
  def index
    if params[:query].present?
      @restaurants = Restaurant.global_search(params[:query])
    else
      @restaurants = Restaurant.all
    end
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

  def show
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
    @review = Review.new
    @reviews = @restaurant.reviews if @restaurant.reviews

  end

  def new
    @restaurant = Restaurant.new
    authorize @restaurant
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    authorize @restaurant
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

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :category, :address, :price_index, :photo, :restaurant_category_id)
  end
end
