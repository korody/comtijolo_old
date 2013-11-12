# encoding:   utf-8
class UserMailer < ActionMailer::Base
  default from: "tijolo@comtijolo.com"

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password Reset"
  end

  def contact(message)
    @message = message
    mail to: "tijolo@comtijolo.com", subject: "Iei! Leitor comtijolo quer conversar. : )"
  end

end
