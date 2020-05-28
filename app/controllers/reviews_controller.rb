class ReviewsController < ApplicationController

  def new
    @review = Review.new
    authorize @review
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def create
    @review = Review.new(review_params)
    authorize @review
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review.restaurant = @restaurant
    @review.user = current_user
    if @review.save
      redirect_to restaurant_path(@restaurant, anchor: "review-#{@review.id}")
    else
      @reviews = @restaurant.reviews
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
    authorize @review

    @restaurant = Restaurant.find(@review.restaurant_id)
    authorize @restaurant
  end

  def update
    @review = Review.find(params[:id])
    authorize @review


    if @review.update(review_params)
      redirect_to restaurant_path(@review.restaurant_id, anchor: "review-#{@review.id}")
    else
      @restaurant = Restaurant.find(@review.restaurant_id)
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    authorize @review
    @review.destroy
    redirect_to restaurant_path(@review.restaurant_id)
  end

  private

  def review_params
    params.require(:review).permit(:global_rating, :poutine_category_id, :service_rating, :fries_rating, :cheese_rating, :sauce_rating, :title, :body, :restaurant_id, photos: [])
  end
end

