if Rails.env.test? # Store the files locally for test environment
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end

if Rails.env.development? or Rails.env.production? # Using Amazon S3 for Development and Production
  CarrierWave.configure do |config|
    config.root = Rails.root.join('public')
    config.cache_dir = 'attachments-cache'

    config.fog_credentials = {
      :provider               => ENV['STORAGE_PROVIDER'],
      :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
      :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
      :region                 => ENV['S3_REGION']
    }
    config.fog_directory  = ENV['S3_BUCKET']
  end
end