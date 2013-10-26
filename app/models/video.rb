class Video < ActiveRecord::Base

  belongs_to :filmable, polymorphic: true

  validates :link, presence: true

end
