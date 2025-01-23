# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user, provider: 'google', uid: '12345') }

  before do
    sign_in user
  end

  describe 'POST #disconnect_google' do
    it 'disconnects the Google account and redirects with a notice' do
      post :disconnect_google
      user.reload
      expect(user.provider).to be_nil
      expect(user.uid).to be_nil
      expect(flash[:notice]).to eq('Cancel linking your Google account.')
      expect(response).to redirect_to(mypages_top_path)
    end
  end
end
