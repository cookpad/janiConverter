class Converter
  include Sidekiq::Worker
  sidekiq_options queue: :transcoder, retry: 3, backtrace: true

  def perform(uuid)
    movie = Movie.where(uuid: uuid).first()
    return unless movie
    movie.converting!
    movie.to_strips.each(&:save)

    if movie.strips.empty?
      movie.error!
    else
      movie.converted!
    end
  end
end
