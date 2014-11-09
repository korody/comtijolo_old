class Collection < ActiveRecord::Base

  has_many :post_collections, dependent: :destroy
  has_many :posts, through: :post_collections
  has_many :users, through: :posts

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

  def self.tokens(query)
    collections = where("name ilike ?", "%#{query}%")
    collections.empty? ? [{id: "<<<#{query}>>>", name: "nova coleção: \"#{query}\""}] : collections
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end

private

  include PgSearch
  pg_search_scope :search, against: :name,
  using: {tsearch: {prefix: true, dictionary: "portuguese"}},
  associated_against: {posts: :name, users: :name},
  ignoring: :accents
  
  def self.text_search(query)
    if query.present?
      search(query)
    else
      all
    end
  end
end