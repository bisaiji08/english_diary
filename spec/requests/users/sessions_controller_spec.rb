# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::SessionsController', type: :request do
  before do
    @request = ActionDispatch::TestRequest.create
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    context 'with invalid credentials' do
      it 'renders the new template with errors' do
        post user_session_path, params: { user: { email: user.email, password: 'wrongpassword' } }
        expect(response.body).to include('Invalid Email or password.')
      end
    end

    context 'with valid credentials and remember_me is checked' do
      it 'logs the user in and sets a remember_me cookie' do
        post user_session_path, params: {
          user: { email: user.email, password: user.password, remember_me: '1' }
        }
        expect(response).to redirect_to(mypages_top_path)
        expect(cookies['remember_user_token']).to be_present
      end
    end

    context 'with valid credentials and remember_me is not checked' do
      it 'logs the user in but does not set a remember_me cookie' do
        post user_session_path, params: {
          user: { email: user.email, password: user.password, remember_me: '0' }
        }
        expect(response).to redirect_to(mypages_top_path)
        expect(cookies['remember_user_token']).to be_nil
      end
    end
  end
end
