class Attachment < ActiveRecord::Base

  belongs_to :attachable, polymorphic: true

  mount_uploader :file, AttachmentUploader

  before_create do
    self.note ||= File.basename(file.filename, '.*').titleize if file
  end

  default_scope order('created_at ASC')   

end
