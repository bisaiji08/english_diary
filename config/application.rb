# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require 'google/cloud/translate'

Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    config.load_defaults 7.0

    config.beginning_of_week = :sunday
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    config.action_controller.forgery_protection_origin_check = false
    config.action_dispatch.cookies_same_site_protection = :strict

    config.generators.system_tests = nil
    config.generators do |g|
      g.skip_routes true
      g.helper false
      g.test_framework nil
    end

    config.active_job.queue_adapter = :sidekiq
  end
end
