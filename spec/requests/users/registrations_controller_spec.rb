# frozen_string_literal: true

require 'rails_helper'

RSpec.describe I18n.t('rspec.controllers.users.registrations_controller'), type: :request do
  before do
    @request = ActionDispatch::TestRequest.create
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe I18n.t('rspec.actions.post_create') do
    context I18n.t('rspec.contexts.invalid_parameters') do
      it I18n.t('rspec.renders_new_template_with_errors') do
        post user_registration_path, params: { user: attributes_for(:user, email: '') }
        expected_message = I18n.t('errors.messages.not_saved', count: 1, resource: 'user')
        puts response.body # デバッグ用にレスポンスを出力
        expect(response.body).to include(expected_message)
      end
    end
  end
end
