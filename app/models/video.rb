class Video < ActiveRecord::Base

  belongs_to :filmable, polymorphic: true

  validates :link, presence: true

  before_save { self.link = link.gsub("watch?v=", "embed/").gsub("http://www", "https://www") }

end
