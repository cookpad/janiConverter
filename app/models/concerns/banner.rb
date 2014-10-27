module Banner
  extend ActiveSupport::Concern

  included do
    belongs_to :movie
    validates_presence_of :movie
    validates_uniqueness_of :movie
    mount_uploader :image, StripUploader
    process_in_background :image
  end
end
