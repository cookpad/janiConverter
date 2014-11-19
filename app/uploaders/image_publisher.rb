class ImagePublisher < CarrierWave::Uploader::Base
  include ::CarrierWave::Backgrounder::Delay

  # see https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-Define-different-storage-configuration-for-each-Uploader.
  def initialize(*)
    super
    StorageSettings.set_to_uploader(self, :publish)
  end

  def store_dir
    "#{Rails.env}/#{Strip.name.underscore.pluralize}/#{model.cached_movie_uuid}"
  end

  module CDNURLFix
    def url(cdn: cdn = true, url_expiration: url_expiration = 24.hours)
      if cdn_path?(cdn)
        fog_directory.match(/\/(.*)/)
        [asset_host, $1, path].join("/")
      else
        self.fog_authenticated_url_expiration = url_expiration
        super
      end
    end

    private

    def cdn_path?(cdn)
      cdn &&
        asset_host &&
        fog_credentials.present? &&
        fog_credentials[:path_style]
    end
  end
  include CDNURLFix
end
