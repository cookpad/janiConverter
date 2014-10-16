class StripUploader < CarrierWave::Uploader::Base
  include ::CarrierWave::Backgrounder::Delay

  # see https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-Define-different-storage-configuration-for-each-Uploader.
  def initialize(*)
    super
    StorageSettings.set_to_uploader(self, :publish)
  end

  def store_dir
    "#{Rails.env}/strips/#{model.movie.uuid}"
  end
end
