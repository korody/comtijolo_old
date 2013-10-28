class User < ActiveRecord::Base

  has_secure_password validations: false

  has_many :posts

  has_many :tags, through: :posts

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 60 }, email_format: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  before_create { self.remember_token = SecureRandom.urlsafe_base64 }
  before_save   { self.email.downcase! }

end
