class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @restaurant = Restaurant.new
  end

  def create
    @review = Review.new(review_params)
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review.restaurant = @restaurant
    @review.user = current_user
    if @review.save
      redirect_to restaurant_path(@restaurant)
    else
      @reviews = @restaurant.reviews
      render 'restaurants/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :title, :body)
  end
end

