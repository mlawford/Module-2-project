class AllUserMailer < ApplicationMailer
  default to: Proc.new { User.pluck(:email) },
          from: 'notification@food-fight.com'

  def new_registration(user)
    @user = user
    mail(subject: "New Food Fight Challenge: #{@user.email}")
  end
end
