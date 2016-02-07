class PostCollection < ActiveRecord::Base
  belongs_to :post
  belongs_to :collection
end