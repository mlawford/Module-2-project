class AllUserMailer < ApplicationMailer
  default to: Proc.new { User.pluck(:email) },
          from: 'notification@food-fight.com'

  def new_challenge(users)
    @users = users
    mail(subject: "New Food Fight Challenge: #{@users.email}")
  end
end
