class Post < ActiveRecord::Base
  attr_reader :category_tokens, :tag_tokens

  belongs_to :user

  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :attachments, as: :attachable, dependent: :destroy

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def category_tokens=(tokens)
    self.category_ids = Category.ids_from_tokens(tokens)
  end

  def tag_tokens=(tokens)
    self.tag_ids = Tag.ids_from_tokens(tokens)
  end

end
