class Converter
  include Sidekiq::Worker

  def perform(uuid)
    movie = Movie.where(uuid: uuid).first()
    return unless movie
    movie.to_strips.each(&:save)
  end
end
