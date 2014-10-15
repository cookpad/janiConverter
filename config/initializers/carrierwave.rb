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
      :path_style             => true,
    }
    config.fog_directory  = 'misc.ap-northeast-1/movie-ad-transcoder/uploads'
    config.fog_public     = false
    config.fog_attributes = {'Cache-Control'=>"max-age=#{365.day.to_i}"}
  end
end
