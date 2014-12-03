source 'https://rubygems.org'

ruby '1.9.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# Slim template engine is awesome
gem 'slim-rails'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Bootstrap to make look nice
gem 'bootstrap-sass', '~> 3.3.0'


group :development, :test do
  gem 'sqlite3' # heroku doesn't like sqlite3 gem
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
  # needed for heroku's default build pack
  gem 'pg'
  gem 'rails_12factor'
end

group :doc do
  gem 'sdoc', require: false
end
