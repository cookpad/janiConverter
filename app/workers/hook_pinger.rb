require "addressable/uri"

class HookPinger
  include Sidekiq::Worker
  sidekiq_options queue: :pinger, retry: 10, backtrace: true

  def perform(callback_url, uuid)
    parsed_url = Addressable::URI.parse(callback_url)
    parsed_url.query_values = (parsed_url.query_values||{}).merge(uuid: uuid)

    response = Faraday.get(parsed_url)
    raise HookRequestError unless response.success? #sidekiq retries
  end

  class HookRequestError < StandardError; end
end
