class MovieSerializer < ActiveModel::Serializer
  attributes :uuid, :frame_width, :frame_height, :fps, :source_url, :pixel_ratio
  has_one :loading_banner, :postroll_banner
  has_many :tracking_events, :strips

  def pixel_ratio
    Movie::PIXEL_RATIO
  end

  def source_url
    object.movie.url
  end
end
