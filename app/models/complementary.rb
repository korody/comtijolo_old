class Complementary < ActiveRecord::Base
  belongs_to :post
  belongs_to :complement, class_name: "Post"
end