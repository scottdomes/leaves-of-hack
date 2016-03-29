class UserMailer < ApplicationMailer
  def deletion_email(user)
    @user = user
    @url = "http://rottenmangos.com"
    mail(to: @user.email, subject: "You got ROCKED (Deletion warning)")
  end
end
