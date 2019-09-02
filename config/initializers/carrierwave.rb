require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_SHIREN2_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SHIREN2_SECRET_ACCESS_KEY'],
      region:                ENV['AWS_SHIREN2_REGION'],
    }

    case Rails.env
    when 'production'
        config.fog_directory  = 'shiren2records'
    when 'development'
        config.fog_directory  = 'devshiren2records'
    end
    config.cache_storage = :fog
end