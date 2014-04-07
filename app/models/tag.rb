class Tag < ActiveRecord::Base

  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings
  has_many :users, through: :posts

  validates :slug, uniqueness: true, presence: true

  before_validation :generate_slug

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= name.parameterize
  end

  def self.tokens(query)
    tags = where("name ilike ?", "%#{query}%")
    tags.empty? ? [{id: "<<<#{query}>>>", name: "nova tag: \"#{query}\""}] : tags
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
