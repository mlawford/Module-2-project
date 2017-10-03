class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = User.find(session[:id])
    if @review.valid?
      @review.save
      redirect_to review_path(@review)
    else
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])

  end

  private

  def review_params
    params.require(:review).permit(:user_id, :restaurant_id, :content)
  end
end
