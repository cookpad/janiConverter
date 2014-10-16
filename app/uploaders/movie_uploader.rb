class MovieUploader < CarrierWave::Uploader::Base
  # see https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-Define-different-storage-configuration-for-each-Uploader.
  def initialize(*)
    super

    unless Rails.env.test?
      upload_settings = StorageSettings.upload
      self.fog_credentials = {
        :provider               => upload_settings.provider,
        :aws_access_key_id      => upload_settings.access_key_id,
        :aws_secret_access_key  => upload_settings.secret_access_key,
        :region                 => upload_settings.region,
        :path_style             => upload_settings.path_style,
      }
      self.fog_directory  = upload_settings.directory
      self.fog_public     = upload_settings.public
      self.fog_attributes = {'Cache-Control'=>"max-age=#{upload_settings.max_age}"}
    end
  end

  def store_dir
    "#{Rails.env}/#{model.class.to_s.underscore.pluralize}/#{model.uuid}"
  end
end
