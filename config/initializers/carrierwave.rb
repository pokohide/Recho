CarrierWave.configure do |config|
  config.cache_dir = Rails.root.join('tmp', 'uploads')

  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'),
    aws_secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
    region: 'ap-northeast-1'
  }

  config.fog_directory = ENV.fetch('AWS_BUCKET_NAME')
  config.cache_storage = :fog
  config.fog_public = true
  config.fog_authenticated_url_expiration = 60
end
