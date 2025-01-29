# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'bootsnap', require: false
gem 'dotenv-rails'
gem 'importmap-rails'
gem 'jbuilder'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.2'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby windows]

gem 'sassc-rails'

gem 'bcrypt', '3.1.20'
gem 'devise', '4.9.4'
gem 'orm_adapter', '0.5.0'
gem 'responders', '3.1.1'
gem 'warden', '1.2.9'

gem 'simple_calendar', '3.0.4'

gem 'google-cloud'
gem 'google-cloud-translate'
gem 'httparty'

gem 'i18n'

gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'

gem 'chronic', '~> 0.10.2'
gem 'redis', '~> 4.8'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'whenever', require: false

gem 'activeadmin'

gem 'mini_magick'

group :development, :test do
  gem 'debug', platforms: %i[mri]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails', '~> 6.0.0'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-capybara', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-rspec_rails', require: false
end

group :development do
  gem 'letter_opener'
  gem 'letter_opener_web'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner-active_record'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 5.0'
end
