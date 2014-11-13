require "jani/strip_maker/movie"
require "jani/strip_maker/transcode_options"

class Movie < ActiveRecord::Base
  has_many :strips
  has_many :tracking_events
  has_one :loading_banner
  has_one :postroll_banner
  validates_presence_of :uuid, :frame_width, :frame_height, :fps, :pixel_ratio
  validates_uniqueness_of :uuid
  accepts_nested_attributes_for :loading_banner, :postroll_banner

  scope :valid, -> do
    where.not(uuid: nil).where.not(frame_width: nil).where.not(frame_height: nil).where.not(fps: nil)
  end

  enum conversion_status: %i(to_be_converted converting converted error)

  mount_uploader :movie, MovieUploader
  process_in_background :movie

  def to_strips
    to_strip_maker_movie.to_strips.map do |strip|
      Strip.new_from_strip_maker_strip(strip_maker_strip: strip, movie: self)
    end
  end

  def tracking_event_for_label(label)
    return nil unless label
    tracking_events.for_label(label)
  end

  def to_html
    view_context.render("movies/movie", movie: self)
  end

  def display_width
    frame_width/pixel_ratio
  end

  def display_height
    frame_height/pixel_ratio
  end

  def frames_count
    strips.sum(:frames_count)
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

  def view_context
    lookup_context = ActionView::LookupContext.new('app/views')
    @_context ||= ActionView::Base.new(lookup_context)
  end
end
