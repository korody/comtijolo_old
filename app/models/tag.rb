class Tag < ActiveRecord::Base

  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings

  def to_param
    name.parameterize
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end

end
