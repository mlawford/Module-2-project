class UserMailer < ApplicationMailer
  def welcome_email(user)
   @user = user
   @url  = 'http://food-fight.com/login'
   mail(to: @user.email, subject: 'Welcome to the Food Fight')
  end
end
