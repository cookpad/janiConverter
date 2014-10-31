class StripSerializer < ActiveModel::Serializer
  attributes :index, :image_url, :frames_count

  def image_url
    object.image.url
  end
end
