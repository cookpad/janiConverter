class Converter
  include Sidekiq::Worker

  def perform(uuid)
    Dir.mktmpdir do |tmp_dir|
      Dir.chdir(tmp_dir) do |dir|
        Movie.where(uuid: uuid).first().to_strips.map(&:write)
        uploader = StripUploader.new
        Dir.glob("*").each do |file|
          uploader.store!(File.open(file))
        end
      end
    end
  end
end
