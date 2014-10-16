class StripUploader < CarrierWave::Uploader::Base
  attr_accessor :movie_uuid

  # see https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-Define-different-storage-configuration-for-each-Uploader.
  def initialize(*)
    super
    StorageSettings.set_to_uploader(self, :publish)
  end

  def store_dir
    "#{Rails.env}/strips/#{movie_uuid}"
  end
end
