class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def welcome

  end

  def login

  end

  def log_user_in
    @user = User.find_by(name: params[:name])
    if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to '/home'
    else
      redirect_to '/login'
    end
  end

  def home
    @user = User.find(session[:user_id])

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
      redirect_to '/login'
  end
end
