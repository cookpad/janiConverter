class Converter
  include Sidekiq::Worker

  def perform(uuid)
    movie = Movie.where(uuid: uuid).first()
    return unless movie
    Dir.mktmpdir do |tmp_dir|
      Dir.chdir(tmp_dir) do |dir|
        movie.to_strips.map(&:write)
        uploader = StripUploader.new
        Dir.glob("*").each { |file| uploader.store!(File.open(file)) }
      end
    end
  end
end
