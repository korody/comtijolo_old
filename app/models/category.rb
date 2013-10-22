class Category < ActiveRecord::Base

  has_many :post_categories, dependent: :destroy
  has_many :posts, through: :post_categories

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end

end
