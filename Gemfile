source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails", "~> 7.1.2"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "dotenv-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby windows ]
gem "bootsnap", require: false

gem 'sassc-rails'

gem 'devise', '4.9.4'
gem 'bcrypt', '3.1.20'
gem 'orm_adapter', '0.5.0'
gem 'responders', '3.1.1'
gem 'warden', '1.2.9'

gem 'simple_calendar', '3.0.4'

gem "google-cloud"
gem "google-cloud-translate"
gem 'httparty'

gem 'i18n'

gem 'letter_opener', group: :development
gem 'letter_opener_web', group: :development

gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'

group :development, :test do
  gem "debug", platforms: %i[ mri ]
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end