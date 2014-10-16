class Strip < ActiveRecord::Base
  belongs_to :movie
  validates_presence_of :frames_count, :index, :movie, :image

  mount_uploader :image, StripUploader
  process_in_background :image

  def self.new_from_strip_maker_strip(strip_maker_strip: strip_maker_strip, movie: movie)
    Strip.new(strip_maker_strip.to_metadata).tap do |new_strip|
      new_strip.movie = movie
      Dir.mktmpdir("#{movie.uuid}-strip-#{new_strip.index}") do |tmpdir|
        Dir.chdir(tmpdir) do |dir|
          strip_maker_strip.write
          new_strip.image = File.open(Dir.glob("*")[0])
        end
      end
    end
  end
end
