source 'https://rubygems.org'
ruby "3.0.4"


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0'

gem 'activerecord-session_store'

# Use SCSS for stylesheets
gem 'sassc-rails', '>= 2.1.0'
gem "bootstrap-sass", ">= 3.4.1"

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 5.0.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'haml-rails'

gem 'omniauth'
gem "omniauth-rails_csrf_protection"
gem "omniauth-twitter2"
gem 'cancancan'

# multi threaded webserver
gem 'puma'
gem 'lograge'
gem 'listen'

gem 'pg', '~> 1.1'

group :development, :test do
  gem 'byebug'
end

group :test do
  gem 'mocha'
  gem 'rails-controller-testing'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

group :production do
  # see https://devcenter.heroku.com/articles/rails4
  gem 'rails_12factor'
end
