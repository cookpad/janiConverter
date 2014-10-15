class MovieUploader < CarrierWave::Uploader::Base
  def store_dir
    "#{Rails.env}/#{model.class.to_s.underscore.pluralize}/#{model.uuid}"
  end
end
