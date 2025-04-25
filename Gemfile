source 'https://rubygems.org'
ruby '3.2.8'

gem 'rails', '~> 5.2.8'
gem 'pg', '~> 1.4.0'
gem 'newrelic_rpm', '~> 8.15.0'
gem 'puma', '~> 5.6'  # Replacing thin with a more modern server
gem 'nokogiri', '~> 1.14.0'
gem 'kaminari', '~> 1.2.2'
gem 'pg_search', '~> 2.3.6'
gem 'devise', '~> 4.9.0'
gem 'json', '~> 2.6.3'
gem 'psych', '< 4'
gem 'bootsnap', require: false
gem 'sassc-rails'

# Assets
gem 'sass-rails', '~> 5.1.0'
gem 'coffee-rails', '~> 5.0.0'
gem 'bootstrap-sass', '~> 3.4.1'
gem 'jquery-rails', '~> 4.5.1'
gem 'jquery-ui-rails', '~> 6.0.1'
gem 'chosen-rails', '~> 1.10.0'
gem 'uglifier', '>= 4.2.0'

# Fixes for Ruby 3.2 compatibility
gem 'net-smtp', require: false
gem 'net-imap', require: false
gem 'net-pop', require: false
gem 'matrix', require: false

group :development, :test do
  gem 'byebug'
  gem 'pry-rails'
  gem 'listen'
end

group :development do
  gem 'web-console', '~> 3.7.0'
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'test-unit'
  gem 'rails-controller-testing'
end