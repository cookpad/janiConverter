CarrierWave::Backgrounder.configure do |configure|
  configure.backend :sidekiq, queue: :movie_upload
end
