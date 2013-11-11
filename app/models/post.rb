class Post < ActiveRecord::Base
  attr_reader :category_tokens, :tag_tokens
  attr_accessor :attachment_ids, :video_ids

  belongs_to :user

  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :videos, as: :filmable, dependent: :destroy

  validates :slug, uniqueness: true, presence: true,
                   exclusion: {in: %w[signup signin]}

  before_validation :generate_slug

  # accepts_nested_attributes_for :attachments, :videos  

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
      Post.all
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

end
