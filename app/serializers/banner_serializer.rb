class BannerSerializer < ActiveModel::Serializer
  attributes :image_url

  def image_url
    object.image.url
  end
end
