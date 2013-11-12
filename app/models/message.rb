class Message
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  attr_accessor :name, :email, :subject, :text

  validates :text, :name, :email, presence: true
  validates :email, email_format: true, allow_blank: true
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end
