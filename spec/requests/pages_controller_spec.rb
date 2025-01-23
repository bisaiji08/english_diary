# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET #terms' do
    it 'renders the terms template' do
      get :terms
      expect(response).to render_template(:terms)
    end
  end

  describe 'GET #privacy' do
    it 'renders the privacy template' do
      get :privacy
      expect(response).to render_template(:privacy)
    end
  end

  describe 'POST #contact' do
    it 'logs the inquiry and redirects with a notice' do
      post :contact, params: { name: 'Test User', email: 'test@example.com', message: 'Hello' }
      expect(flash[:notice]).to eq('Your inquiry has been sent.')
      expect(response).to redirect_to(contact_path)
    end
  end
end
