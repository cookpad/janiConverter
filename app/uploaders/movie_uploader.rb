class MovieUploader < CarrierWave::Uploader::Base
  include ::CarrierWave::Backgrounder::Delay

  # see https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-Define-different-storage-configuration-for-each-Uploader.
  def initialize(*)
    super
    StorageSettings.set_to_uploader(self, :upload)
  end

  def store_dir
    "#{Rails.env}/#{model.class.to_s.underscore.pluralize}/#{model.uuid}"
  end
end
