class AttachmentUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  include CarrierWave::MimeTypes

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  storage :fog

  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "logo.png"
  end

# Process files as they are uploaded:
  process   :resize_to_fill => [1920, 1080]
  

  version :tiny do
    process :resize_to_fill => [32, 32]
  end

  version :medium do
    process :resize_to_fill => [120, 120]
  end

  version :regular do
    process :resize_to_fill => [700, 394]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end