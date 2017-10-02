class UsersController < ApplicationController
  # before_action :logged_in
  # skip_before_action :logged_in, only: [:new]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session.delete :id
      session[:user_id] = @user.id
       redirect_to '/home'
     else
       redirect_to '/user/new'
    end
  end

  def show
    @user = User.find(params[:id])
  end




  private

  def user_params
    params.require(:user).permit(:name,:bio,:EXP,:favorite_food,:password,:password_confirmation)
  end

  def logged_in
     return head(:forbidden) unless session.include? :name
  end


end
