class ImagePublisher < CarrierWave::Uploader::Base
  include ::CarrierWave::Backgrounder::Delay

  # see https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-Define-different-storage-configuration-for-each-Uploader.
  def initialize(*)
    super
    StorageSettings.set_to_uploader(self, :publish)
  end

  def store_dir
    "#{Rails.env}/strips/#{model.movie.uuid}"
  end

  module CDNURLFix
    def url
      if asset_host && fog_credentials.present? && fog_credentials[:path_style]
        fog_directory.match(/\/(.*)/)
        [asset_host, $1, path].join("/")
      else
        super
      end
    end
  end
  include CDNURLFix
end
