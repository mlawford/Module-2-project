class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def welcome

  end

  def login

  end

  def log_user_in
    @user = User.find_by(name: params[:name])
    if @user.authenticate(params[:password])
        session[:id] = @user.id
        redirect_to '/home'
    else
      redirect_to '/login'
    end
  end

  def home
    @top_users = User.all.sort_by{|user| user.EXP}.reverse.take(3)

    @users = Challenge.last.users.sort_by{|user| user.reviews.length}.reverse

    @user = User.find(session[:id])

  end

  # def log_user_in
  #   @user = User.find_by(params[:id])
  #   if @user != nil || @user != ""
  #     session[:id] = @user.id
  #     redirect_to '/home'
  #   else
  #     redirect_to '/users/new'
  #   end
  # end

  def logout
    unless session[:id] == nil
      session.delete :id
    end
      redirect_to '/'
  end
end
