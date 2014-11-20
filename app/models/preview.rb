class Preview < ActiveRecord::Base
  include MovieUUIDCacheable
  belongs_to :movie
  validates_presence_of :movie
  validates_uniqueness_of :movie
  mount_uploader :html, ImagePublisher
  process_in_background :html

  FILE_EXTENTION = "html"

  def to_html(layout: layout = "layouts/preview")
    return "" unless movie.try(:converted?)
    movie.to_preview_html(layout: layout)
  end

  def write
    File.open(filename, "w") do |file|
      file.write(to_html)
    end
  end

  def self.new_from_movie(movie)
    Preview.new.tap do |new_preview|
      new_preview.movie = movie
      Dir.mktmpdir("#{movie.uuid}-preview") do |tmpdir|
        Dir.chdir(tmpdir) do
          new_preview.write
          new_preview.html = File.open(Dir.glob("*")[0])
        end
      end
    end
  end

  private

  def filename
    "index.#{FILE_EXTENTION}"
  end
end
