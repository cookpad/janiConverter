CarrierWave.configure do |config|
  config.permissions = 0666
  config.directory_permissions = 0777

  if Rails.env.test?
    config.storage = :file
  else
    config.storage = :fog
  end
end
