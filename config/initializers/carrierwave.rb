CarrierWave.configure do |config|
  config.permissions = 0666
  config.directory_permissions = 0777

  if Rails.env.test?
    config.storage = :file
  else
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => Rails.application.secrets.aws_access_key_id,
      :aws_secret_access_key  => Rails.application.secrets.aws_secret_access_key,
      :region                 => 'ap-northeast-1',
      :host                   => 'misc.ap-northeast-1.s3.amazonaws.com',
      # :endpoint               => 'https://s3.example.com:8080', # optional, defaults to nil
    }
    config.fog_directory  = 'movie-ad-transcoder/uploads'                 # required
    config.fog_public     = false                                        # optional, defaults to true
    config.fog_attributes = {'Cache-Control'=>"max-age=#{365.day.to_i}"} # optional, defaults to {}
  end
end
