class UsersController < ApplicationController
  # before_action :logged_in
  # skip_before_action :logged_in, only: [:new]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save

      session[:id] = @user.id
       redirect_to '/home'
     else
       render :new
     end
  end

  def show
    @user = User.find(params[:id])
  end

  def join_challenge
    @user = User.find(session[:id])
    @current_challenge = Challenge.last
    if @current_challenge.users.include?(@user)
      redirect_to '/home'
    else
      UserChallenge.create(:user_id => @user.id, :challenge_id => @current_challenge.id)
      redirect_to '/home'
    end
  end




  private

  def user_params
    params.require(:user).permit(:name,:bio,:EXP,:favorite_food,:password,:password_confirmation)
  end

  def logged_in
     return head(:forbidden) unless session.include? :name
  end


end
