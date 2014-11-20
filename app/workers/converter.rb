class Converter
  include Sidekiq::Worker
  sidekiq_options queue: :transcoder, retry: 3, backtrace: true

  def perform(uuid, callback_url = nil)
    movie = Movie.where(uuid: uuid).first()
    return unless movie
    movie.converting!
    movie.to_strips.each(&:save)

    if movie.strips.empty?
      movie.error!
    else
      movie.converted!
      Preview.new_from_movie(movie).save!
      HookPinger.perform_async(callback_url, uuid) if callback_url
    end
  end
end
