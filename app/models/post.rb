class Post < ActiveRecord::Base
  attr_reader :category_tokens, :tag_tokens, :complements_tokens
  attr_accessor :attachment_ids, :video_ids

  belongs_to :user

  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :videos, as: :filmable, dependent: :destroy

  validates :slug, uniqueness: true, presence: true,
                   exclusion: {in: %w[signup signin signout]}

  has_many :complementaries, dependent: :destroy
  has_many :complements, through: :complementaries

  before_validation :generate_slug

  default_scope order('created_at DESC')    

  scope :next, lambda {|id| where("id > ?",id).order("id ASC") } # this is the default ordering for AR
  scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }

  def next
    Post.next(self.id).first
  end

  def previous
    Post.previous(self.id).first
  end  

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= name.parameterize
  end

  def self.filter(params)
    if params[:tag]
      tagged_with(params[:tag])
    else
      all
    end
  end

  def self.tagged_with(slug)
    Tag.find_by_slug!(slug).posts
  end

  def category_tokens=(tokens)
    self.category_ids = Category.ids_from_tokens(tokens)
  end

  def tag_tokens=(tokens)
    self.tag_ids = Tag.ids_from_tokens(tokens)
  end

  def complements_tokens=(tokens)
    self.complement_ids = Post.ids_from_tokens(tokens)
  end

  def self.tokens(query)
    posts = where("name ilike ?", "%#{query}%")
    posts.empty? ? [{id: "<<<#{query}>>>", name: "NENHUM POST \"#{query}\" FOI ENCONTRADO!"}] : posts
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end

private

  include PgSearch
  pg_search_scope :search, against: [:name, :description],
  using: {tsearch: {prefix: true, dictionary: "portuguese"}},
  associated_against: {user: :name, tags: :name, categories: :name},
  ignoring: :accents
  
  def self.text_search(query)
    if query.present?
      search(query)
    else
      all
    end
  end

end
