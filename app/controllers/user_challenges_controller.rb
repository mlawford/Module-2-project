class UserChallengesController < ApplicationController

    def new
      @user_challenge = UserChallenge.new
    end

    def create
      @user_challenge = UserChallenge.create(user_challenge_params)
    end

    def show
      @user_challenge = UserChallenge.find(params[:id])
    end

    private

    def user_challenge_params
      params.require(:user_challenge).permit(:user_id, :challenge_id)
    end

end
