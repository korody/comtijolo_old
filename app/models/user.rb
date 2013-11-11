class User < ActiveRecord::Base
  attr_accessor :attachment_ids, :video_ids

  has_secure_password validations: false

  has_many :posts

  has_many :tags, through: :posts

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :videos, as: :filmable, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 60 }, email_format: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  before_create { self.remember_token = SecureRandom.urlsafe_base64 }
  before_validation { self.slug ||= name.parameterize }
  before_save   { self.email.downcase! }

  def to_param
    slug
  end

end
