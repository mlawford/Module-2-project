class RestaurantChallengesController < ApplicationController

  def new
    @restaurant_challenge = RestaurantChallenge.new
  end

  def create
    @restaurant_challenge = RestaurantChallenge.create(restaurant_challenge_params)
    redirect_to '/restaurant_challenges/new'
  end

  def show
    @restaurant_challenge = RestaurantChallenge.find(params[:id])
  end

  private

  def restaurant_challenge_params
    params.require(:restaurant_challenge).permit(:restaurant_id, :challenge_id)
  end
end
