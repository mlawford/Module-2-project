class UsersController < ApplicationController
  before_action :logged_in
  skip_before_action :logged_in, only: [:new, :create]
  def new
    @user = User.new
  end

  def index
    @users = User.all
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

  def edit
    @user = User.find(params[:id])
    if @user.id != session[:id]
      redirect_to '/home'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.valid?
      @user.save
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def home

    if Challenge.all.length > 0
      @top_users = User.all.sort_by{|user| user.EXP}.reverse.take(3)
      @users = Challenge.last.users.sort_by{|user| user.reviews.length}.reverse
    end

    @user = User.find(session[:id])

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
     redirect_to'/' unless session.include? :id
  end


end
