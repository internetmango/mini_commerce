# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 2.6.5'

gem 'activeadmin'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise'
gem 'haml-rails'
gem 'jbuilder', '~> 2.7'
gem 'kaminari'
gem 'pg', '>= 0.18', '< 2.0'
gem 'pg_search', '~> 2.2'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'
gem 'pagy', '~> 3.7.4'
gem 'shrine', '~> 3.2.1'
gem 'pundit', '~> 2.1.0'
gem 'fast_jsonapi'
gem 'rack-cors'
gem 'bootstrap-datepicker-rails'
gem 'chart-js-rails'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'letter_opener'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'database_cleaner'
  gem 'simplecov'
  gem 'codecov', require: false
end

group :production do
  gem 'aws-sdk-s3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
