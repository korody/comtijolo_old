class PasswordReset
  attr_reader :user

  def self.from_email(email)
    new User.find_by(email: email)
  end

  def self.from_token(token)
    new User.find_by!(reset_token: token)
  end

  def initialize(user)
    @user = user
  end

  def send_email
    generate_token
    user.reset_token_sent_at = Time.zone.now
    user.save! validate: false
    UserMailer.password_reset(user).deliver
  end

  def expired?
    user.password_reset_sent_at < 2.hours.ago
  end

  private

  def generate_token
    begin
      user.reset_token = SecureRandom.urlsafe_base64
    end while User.exists?(reset_token: user.reset_token)
  end
end