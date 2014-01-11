Carrierwave.configure do |config|
  config.fog_credentials = {
    provider: ENV['STORAGE_PROVIDER'],
    google_storage_access_key_id: ENV['STORAGE_KEY'],      
    google_storage_secret_access_key: ENV['STORAGE_SECRET']
  }
  config.fog_directory = ENV['STORAGE_BUCKET']
end