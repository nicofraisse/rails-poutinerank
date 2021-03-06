class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, :only => :update, :if => lambda {
    if params['vote_type']
      true
    else
      false
    end
  }

  def new
    @review = Review.new
    authorize @review
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def create
    @review = Review.new(review_create_params)
    @review.update(upvotes: 0)
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

    if @review.update(review_edit_params)

      if params[:vote_type] == "upvote" && @review.user != current_user
        if params[:review]["up_enabled"] == "true"
          @review.increment!(:upvotes)
          @review.save
        elsif params[:review]["up_enabled"] == "trueSpam"
          @review.decrement!(:upvotes)
          @review.save
        elsif params[:review]["up_enabled"] == "trueChangedMyMind"
          @review.increment!(:upvotes)
          @review.increment!(:upvotes)
          @review.save
        end
      elsif params[:vote_type] == "downvote" && @review.user != current_user
        if params[:review]["down_enabled"] == "true"
          @review.decrement!(:upvotes)
          @review.save
        elsif params[:review]["down_enabled"] == "trueSpam"
          @review.increment!(:upvotes)
          @review.save
        elsif params[:review]["down_enabled"] == "trueChangedMyMind"
          @review.decrement!(:upvotes)
          @review.decrement!(:upvotes)
          @review.save
        end
      else
        redirect_to restaurant_path(@review.restaurant_id, anchor: "review-#{@review.id}")
      end
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

  def review_create_params
    params.require(:review).permit(:down_enabled, :up_enabled, :global_rating, :poutine_category_id, :service_rating, :fries_rating, :cheese_rating, :sauce_rating, :title, :body, :restaurant_id, photos: [])
  end

  def review_edit_params
    if @review.user == current_user
      params.require(:review).permit(:global_rating, :poutine_category_id, :service_rating, :fries_rating, :cheese_rating, :sauce_rating, :title, :body, :restaurant_id, photos: [])
    else
      params.require(:review).permit()
    end
  end
end

