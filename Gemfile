source "https://rubygems.org"

# rails things(mostly by rails new)
gem "rails",            github: "rails/rails", branch: "4-1-stable"
gem "sprockets-rails",  github: "rails/sprockets-rails", branch: "2-1-stable"
gem "sass-rails",       github: "rails/sass-rails"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails",     github: "rails/coffee-rails"
gem "jquery-rails"
gem "therubyracer", platforms: :ruby
gem "bcrypt", "~> 3.1.7"

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

# queue
gem 'sidekiq'
gem 'sinatra', require: false
gem 'slim'

group :development do
  gem "spring"
  gem "factory_girl_rails"
  gem "quiet_assets"
  gem "better_errors", github: "charliesome/better_errors"
  gem "binding_of_caller", github: "banister/binding_of_caller"
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
  gem "autodoc", github: "shin1ohno/autodoc", ref: "61dc733"
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
  gem 'guard-rspec'
  gem "spring-commands-rspec"
  gem "codeclimate-test-reporter", require: nil
end
