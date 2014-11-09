class Category < ActiveRecord::Base

  has_many :post_categories, dependent: :destroy
  has_many :posts, through: :post_categories

  has_many :collections, through: :posts
  has_many :tags, through: :posts

  validates :slug, uniqueness: true, presence: true

  before_validation :generate_slug

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= name.parameterize
  end

  def self.tokens(query)
    categories = where("name ilike ?", "%#{query}%")
    categories.empty? ? [{id: "<<<#{query}>>>", name: "NENHUMA CATEGORIA \"#{query}\" ENCONTRADA!"}] : categories
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end
end