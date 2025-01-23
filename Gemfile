# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'activeadmin'
gem 'bcrypt', '3.1.20'
gem 'chronic', '~> 0.10.2'
gem 'devise', '4.9.4'
gem 'dotenv-rails'
gem 'google-cloud'
gem 'google-cloud-translate'
gem 'httparty'
gem 'i18n'
gem 'importmap-rails'
gem 'jbuilder'
gem 'orm_adapter', '0.5.0'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.2'
gem 'redis-client', '~> 0.23.1'
gem 'responders', '3.1.1'
gem 'sassc-rails'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'simple_calendar', '3.0.4'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby windows]
gem 'warden', '1.2.9'
gem 'whenever', require: false

group :development do
  gem 'letter_opener'
  gem 'letter_opener_web'
  gem 'web-console'
end

group :development, :test do
  gem 'debug', platforms: %i[mri]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails', '~> 6.0.0'
  gem 'rubocop', require: false
end

group :test do
  gem 'capybara'
  gem 'database_cleaner-active_record'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 5.0'
end
