module MovieUUIDCacheable
  extend ActiveSupport::Concern

  def cached_movie_uuid
    Rails.cache.fetch("movie:uuid:#{movie_id}") do
      movie.uuid
    end
  end
end
