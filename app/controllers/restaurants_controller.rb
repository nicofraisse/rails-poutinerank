class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    authorize @restaurant
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
      raise
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
    params.require(:restaurant).permit(:name, :category, :address, :price_index, :restaurant_category_id)
  end
end
