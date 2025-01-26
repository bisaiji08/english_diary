# frozen_string_literal: true

require 'rails_helper'

RSpec.describe I18n.t('rspec.controllers.users.sessions_controller'), type: :request do
  before do
    @request = ActionDispatch::TestRequest.create
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    context 'with invalid credentials' do
      it 'renders the new template with errors' do
        post user_session_path, params: { user: { email: user.email, password: 'wrongpassword' } }

        # フラッシュメッセージの確認
        expect(flash[:alert]).to eq(I18n.t('devise.failure.invalid', authentication_keys: 'Email'))

        # レスポンスボディの確認
        expect(response.body).to include(I18n.t('devise.failure.invalid', authentication_keys: 'Email'))
      end
    end

    context I18n.t('rspec.contexts.valid_credentials_remember_me_checked') do
      it I18n.t('rspec.logs_in_and_sets_remember_me_cookie') do
        post user_session_path, params: {
          user: { email: user.email, password: user.password, remember_me: '1' }
        }
        expect(response).to redirect_to(mypages_top_path)
        expect(cookies['remember_user_token']).to be_present
      end
    end

    context I18n.t('rspec.contexts.valid_credentials_remember_me_unchecked') do
      it I18n.t('rspec.logs_in_does_not_set_remember_me_cookie') do
        post user_session_path, params: {
          user: { email: user.email, password: user.password, remember_me: '0' }
        }
        expect(response).to redirect_to(mypages_top_path)
        expect(cookies['remember_user_token']).to be_nil
      end
    end
  end
end
