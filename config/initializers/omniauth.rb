# frozen_string_literal: true

OmniAuth.config.logger = Rails.logger
OmniAuth.config.allowed_request_methods = %i[post get]

OmniAuth.config.on_failure = proc do |env|
  message = env['omniauth.error.type']
  strategy = env['omniauth.error.strategy'].name
  Rails.logger.error "OmniAuth Error: #{strategy} - #{message}"
  [302, { 'Location' => "/auth/failure?message=#{message}" }, []]
end
