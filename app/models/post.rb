class Post < ActiveRecord::Base
  attr_reader :category_tokens

  belongs_to :user

  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def category_tokens=(tokens)
    self.category_ids = Category.ids_from_tokens(tokens)
  end

end
