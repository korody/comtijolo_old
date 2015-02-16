class Post < ActiveRecord::Base
  attr_reader :category_tokens, :collection_tokens, :tag_tokens, :complements_tokens
  attr_accessor :attachment_ids, :video_ids

  belongs_to :user

  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories

  has_many :post_collections, dependent: :destroy
  has_many :collections, through: :post_collections

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :videos, as: :filmable, dependent: :destroy

  validates :slug, uniqueness: true, presence: true,
                   exclusion: {in: %w[signup signin signout]}
  validates :content, presence: true

  has_many :complementaries, dependent: :destroy
  has_many :complements, through: :complementaries

  before_validation :generate_slug
  before_save :cook_html

  default_scope { order(created_at: :desc) }

  scope :next, lambda {|id| where("id > ?",id).order("id ASC") } # this is the default ordering for AR
  scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }

  def all_images
    attachments.map { |attachment| attachment.file.medium.url.to_s }    
  end

  def cover
    all_images.first
  end

  def other_images
    all_images.drop(1)
  end

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

  def self.from_collection(slug)
    Collection.find_by_slug!(slug).posts
  end

  def self.tagged_with(slug)
    Tag.find_by_slug!(slug).posts
  end

  def category_tokens=(tokens)
    self.category_ids = Category.ids_from_tokens(tokens)
  end

  def collection_tokens=(tokens)
    self.collection_ids = Collection.ids_from_tokens(tokens)
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

  def cook_html
    html = Markdown.new(content, SmartyRenderer.new).to_html
    self.html = Sanitize.clean(html, PostSanitizer::FILTER)
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