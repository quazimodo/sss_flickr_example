source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'slim-rails'
# Slim template engine is awesome

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0'
  gem 'capybara'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-zeus'
  gem 'dotenv-rails' # set environment variables in tests
end

group :test do
  gem 'webmock' # Stub out http requests in tests
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :doc do
  gem 'sdoc', require: false
end
