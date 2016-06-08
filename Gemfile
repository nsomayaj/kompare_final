source 'http://rubygems.org'

# adds zomato
gem 'zomato'

# for api keys
gem 'figaro'

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :development do
  gem 'sqlite3'
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  gem "better_errors"
  gem "binding_of_caller"
end

# k means gems
# gem 'rmagick', '~> 2.13.2'

# group :test do
#   gem 'rspec', '~> 2.14.0'
#   gem 'rcov', :platforms => :mri_18
#   gem 'simplecov'
#   gem 'simplecov-rcov'
# end
#
# group :development do
#   gem "cucumber"
#   gem "bundler"
#   gem "jeweler"
# end

gem 'rspec-rails', group: [:test, :development]
gem 'capybara', group: [:test, :development]
gem 'quiet_assets', group: [:test, :development]
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
