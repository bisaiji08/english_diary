# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user, provider: 'google', uid: '12345') }

  before do
    sign_in user
  end

  describe I18n.t('rspec.actions.post_disconnect_google') do
    it I18n.t('rspec.disconnects_google_account_redirects_with_notice') do
      post :disconnect_google
      user.reload
      expect(user.provider).to be_nil
      expect(user.uid).to be_nil
      expect(flash[:notice]).to eq(I18n.t('users.google.disconnect_success'))
      expect(response).to redirect_to(mypages_top_path)
    end
  end
end
