source "https://rubygems.org"

# rails things(mostly by rails new)
gem "rails",            github: "rails/rails", branch: "4-2-stable"
gem "sprockets-rails", require: "sprockets/railtie"
gem "sass-rails",       github: "rails/sass-rails"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails",     github: "rails/coffee-rails"
gem "jquery-rails"
gem "therubyracer", platforms: :ruby
gem "bcrypt", "~> 3.1.7"
gem "active_model_serializers"
gem "kaminari"
gem "addressable"

# for deprecation of respond_to/respond_with in Rails 4.2
gem "responders", "~> 2.0"

# database
if ENV["DB"] == "sqlite"
  gem "sqlite3"
elsif ENV["DB"] == "postgresql"
  gem "pg"
else
  gem "mysql2"
end

# settings
gem "settingslogic"

# web server
gem "puma"

# movie -> jani converter
gem "jani-strip_maker"

# file uploader
gem "carrierwave"
gem "fog", require: "fog/aws/storage"
gem 'carrierwave_backgrounder'

# queue
gem 'sidekiq'
gem 'sinatra', require: false
gem 'slim'

# style
gem "bourbon"
gem "neat"
gem "bitters"
gem "refills"

# http
gem "faraday"

group :development do
  gem "spring"
  gem "factory_girl_rails"
  gem "quiet_assets"
  gem "better_errors", github: "charliesome/better_errors"
  gem "binding_of_caller", github: "banister/binding_of_caller"
  gem "guard-rspec"
  gem "guard-livereload", require: false
  gem "rack-livereload"
end

group :test do
  gem "rspec"
  gem "rspec-mocks"
  gem "rspec-core"
  gem "rspec-expectations"
  gem "rspec-support"
  gem "rspec-collection_matchers"
  gem "simplecov", require: false
  gem "database_cleaner"
  gem "capybara"
  gem "poltergeist"
  gem "timecop"
  gem "autodoc"
  gem "webmock"
  gem "vcr"
end

group :development, :test do
  gem 'faker'
  gem 'launchy'
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'awesome_print'
  gem 'activerecord-import'
  gem "spring-commands-rspec"
  gem "codeclimate-test-reporter", require: nil
end
