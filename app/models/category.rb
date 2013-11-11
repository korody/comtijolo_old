class Category < ActiveRecord::Base

  has_many :post_categories, dependent: :destroy
  has_many :posts, through: :post_categories

  has_many :tags, through: :posts

  validates :slug, uniqueness: true, presence: true

  before_validation :generate_slug

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= name.parameterize
  end

  def self.filter(params)
    if params[:tag]
      Post.tagged_with(params[:tag])
    else
      @posts = Post.scoped(limit: 10)
    end
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end

end
