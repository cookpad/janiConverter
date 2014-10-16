class StorageSettings < Settingslogic
  source "#{Rails.root}/config/strages.yml"
  namespace Rails.env

  def self.set_to_uploader(uploader, storage)
    unless Rails.env.test?
      publish_settings = StorageSettings.send(storage.to_sym)
      uploader.fog_credentials = {
        :provider               => publish_settings.provider,
        :aws_access_key_id      => publish_settings.access_key_id,
        :aws_secret_access_key  => publish_settings.secret_access_key,
        :region                 => publish_settings.region,
        :path_style             => publish_settings.path_style,
      }
      uploader.fog_directory  = publish_settings.directory
      uploader.fog_public     = publish_settings.public
      uploader.fog_attributes = {'Cache-Control'=>"max-age=#{publish_settings.max_age}"}
    end
  end
end
