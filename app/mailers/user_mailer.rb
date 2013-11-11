# encoding:   utf-8
class UserMailer < ActionMailer::Base
  default from: "ola@comtijolo.com"

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password Reset"
  end

end
