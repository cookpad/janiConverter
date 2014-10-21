#place file in config and add prefix 0_
#for load this class prior than other initializers
class RedisSettings < Settingslogic
  source "#{Rails.root}/config/redis.yml"
  namespace Rails.env
end
