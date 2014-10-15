require "jani/strip_maker/movie"
require "jani/strip_maker/transcode_options"

class Movie < ActiveRecord::Base
  mount_uploader :movie, MovieUploader
  validates_presence_of :uuid, :frame_width, :frame_height, :fps

  def to_strips
    to_strip_maker_movie.to_strips
  end

  private

  def to_strip_maker_movie
    movie.cache!
    Jani::StripMaker::Movie.new(
      movie_filepath: movie.path, transcode_options: transcode_options
    )
  end

  def transcode_options
    Jani::StripMaker::TranscodeOptions.new.tap do |transcode_options|
      transcode_options.fps = self.fps
      transcode_options.width = self.frame_width
      transcode_options.height = self.frame_height
    end
  end
end
