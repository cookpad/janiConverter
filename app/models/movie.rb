class Movie < ActiveRecord::Base
  mount_uploader :movie, MovieUploader
  validates_presence_of :uuid, :frame_width, :frame_height, :fps
end
