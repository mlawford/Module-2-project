class RestaurantsController < ApplicationController

  def index
    if params[:q].nil? || params[:q] == ""
      @restaurants = Restaurant.all
    else
      @restaurants = Restaurant.where("name LIKE ?", "%#{params[:q]}%")
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    redirect_to restaurant_path(@restaurant)
  end

  def show
    @restaurant = Restaurant.find(params[:id])

  end

  def search
    byebug
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name,:cuisine)
  end

  def search_params
    params.permit(:q)
  end

end
