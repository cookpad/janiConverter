class StripUploader < CarrierWave::Uploader::Base
  attr_accessor :movie_uuid

  # see https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-Define-different-storage-configuration-for-each-Uploader.
  def initialize(*)
    super

    unless Rails.env.test?
      publish_settings = StorageSettings.publish
      self.fog_credentials = {
        :provider               => publish_settings.provider,
        :aws_access_key_id      => publish_settings.access_key_id,
        :aws_secret_access_key  => publish_settings.secret_access_key,
        :region                 => publish_settings.region,
        :path_style             => publish_settings.path_style,
      }
      self.fog_directory  = publish_settings.directory
      self.fog_public     = publish_settings.public
      self.fog_attributes = {'Cache-Control'=>"max-age=#{publish_settings.max_age}"}
    end
  end

  def store_dir
    "#{Rails.env}/strips/#{movie_uuid}"
  end
end
