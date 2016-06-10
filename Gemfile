source 'https://rubygems.org'
ruby '2.2.2'

gem 'rename'
gem 'rails', '4.2.5.2'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'devise'
gem 'friendly_id', '~> 5.1.0'
gem 'responders', '~> 2.0'
gem 'rack-cors', require: 'rack/cors'
gem 'factory_girl_rails'
gem 'faker'
gem 'geocoder'
gem 'colorize'
gem 'simple_token_authentication'
gem 'newrelic_rpm'
gem 'slack-notifier'
gem 'materialize-sass'
gem 'will_paginate-materialize'
gem 'jquery-validation-rails'
gem 'inline_svg'
gem 'gon', '~> 6.0.1'
gem 'twitter-typeahead-rails'
gem 'cloudinary', '~> 1.1.3'
gem 'attachinary', '~> 1.3.1'
gem 'lodash-rails'
gem 'zeroclipboard-rails'
gem 'mustache-js-rails', '~> 2.0.3'
gem 'sprockets', '>= 3.0.0'
gem 'sprockets-es6'
gem 'bower-rails', '~> 0.10.0'

group :production do
  gem 'puma'
  gem 'rack-timeout'
  gem 'rails_12factor'
end

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  gem 'derailed'
  gem 'guard-livereload', '~> 2.4', require: false
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'rspec-rails'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'bullet'
  gem 'letter_opener'
  gem 'meta_request'
end

group :test do
  gem 'codeclimate-test-reporter', require: nil
  gem 'selenium-webdriver', '~> 2.53'
  gem 'cucumber-rails', require: false
  gem 'launchy'
  gem 'database_cleaner'
  gem 'simplecov', require: false
end
