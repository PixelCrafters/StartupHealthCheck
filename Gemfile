source 'https://rubygems.org'
ruby '2.1.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# bootstrap
gem 'bootstrap-sass', '~> 3.1.1'

gem 'friendly_id', '~> 5.0.0'
gem 'searchkick'
gem 'faraday'
gem 'auth0'
gem 'jwt', '0.1.11' #to fix dependency issue with jwt on heroku 
gem 'acts-as-taggable-on', '3.2.3'
gem 'public_activity'
gem 'rails_12factor', group: :production
gem 'themes_on_rails'
gem 'kaminari-bootstrap', '~> 3.0.1'

# active admin
gem 'activeadmin', github: 'gregbell/active_admin'
gem 'devise'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'pry'
  gem 'pry-debugger'
  gem 'dotenv-rails'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  gem 'spring'
  gem 'better_errors'
  gem 'binding_of_caller'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
