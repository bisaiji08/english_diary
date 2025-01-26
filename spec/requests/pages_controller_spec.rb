# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe I18n.t('rspec.actions.get_terms') do
    it I18n.t('rspec.renders_terms_template') do
      get :terms
      expect(response).to render_template(:terms)
    end
  end

  describe I18n.t('rspec.actions.get_privacy') do
    it I18n.t('rspec.renders_privacy_template') do
      get :privacy
      expect(response).to render_template(:privacy)
    end
  end

  describe I18n.t('rspec.actions.post_contact') do
    it I18n.t('rspec.logs_inquiry_redirects_with_notice') do
      post :contact, params: { name: 'Test User', email: 'test@example.com', message: 'Hello' }
      expect(flash[:notice]).to eq(I18n.t('pages.contact.success'))
      expect(response).to redirect_to(contact_path)
    end
  end
end
