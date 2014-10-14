# encoding: utf-8

class MovieUploader < CarrierWave::Uploader::Base
  def store_dir
    "#{model.class.to_s.underscore}/#{model.uuid}"
  end
end
