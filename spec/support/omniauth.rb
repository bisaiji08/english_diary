# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:each) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid: '12345',
      info: {
        email: I18n.t('omniauth.mock_auth.email', default: 'test@example.com'),
        name: I18n.t('omniauth.mock_auth.name', default: 'Test User')
      }
    )
  end

  config.after(:each) do
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end
end
