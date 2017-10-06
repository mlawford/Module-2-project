class ChallengesController < ApplicationController

  def index
    @challenges = Challenge.all
  end

  def new
    @challenge = Challenge.new
  end

  def create
    @challenge = Challenge.create(challenge_params)
    redirect_to challenge_path(@challenge)
  end

  def show
    @challenge = Challenge.find(params[:id])
  end

  private

  def challenge_params
    params.require(:challenge).permit(:start,:end,:description, :reward)
  end
end
