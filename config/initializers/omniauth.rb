OmniAuth.config.logger = Rails.logger

OmniAuth.config.on_failure = Proc.new { |env|
  message = env['omniauth.error.type']
  strategy = env['omniauth.error.strategy'].name
  Rails.logger.error "OmniAuth Error: #{strategy} - #{message}"
  [302, { 'Location' => "/auth/failure?message=#{message}" }, []]
}
