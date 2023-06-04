source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4", ">= 7.0.4.3"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# State machine
gem 'aasm'

# Taggable 
gem 'acts-as-taggable-on', '~> 9.0'

# Annotation
gem 'annotate'

# CORS
gem 'rack-cors'

# Authenticate
gem 'devise'
gem 'devise-jwt'

# Serializer
gem 'jsonapi-serializer'

gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"

# SQL queries
gem 'sql_query'

# Image processing
gem "ruby-vips"

# Authorization
gem 'pundit'

# Validate Urls
# https://github.com/perfectline/validates_url
gem "validate_url"

# Date time validations
gem 'validates_timeliness', '~> 7.0.0.beta2'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

# ruby server language
gem 'solargraph'

# Phone numbers with validation
gem 'phonelib'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]

  # Security tests
  gem 'brakeman'

  # Deployment
  gem 'capistrano', '~> 3.16', require: false
  gem 'capistrano-rails', '~> 1.6', require: false

  # # integrate bundler with capistrano
  gem 'capistrano3-puma', github: 'seuros/capistrano-puma'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'
  
  # Clean database before testing
  gem 'database_cleaner-active_record'

  # Ed25519 keys support
  gem 'ed25519', '>= 1.2', '< 2.0'

  # Fake entities creation
  gem 'faker'

  # Create entities
  gem 'factory_bot_rails'

  # Validate api json returns
  gem 'json-schema'

  # Validate json responses
  gem 'jsonapi-rspec'

  # Parallel tests
  gem 'parallel_tests'

  # Rspec TDD
  gem 'rspec'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'
  # RSpec formatters
  gem 'rspec-sonarqube-formatter', '~> 1.5', require: false

  # Code quality
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'rubocop-factory_bot'

  # Code coverage
  gem 'simplecov'
  gem 'simplecov-json'

  # Validate associations
  gem 'shoulda-matchers', '~> 5.0'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem 'shoulda-matchers', '~> 5.0'
end

