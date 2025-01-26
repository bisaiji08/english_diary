# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe I18n.t('rspec.methods.from_omniauth') do
    let(:auth_hash) do
      OmniAuth::AuthHash.new(
        provider: 'google_oauth2',
        uid: '12345',
        info: {
          email: 'test@example.com',
          name: 'Test User',
          image: 'http://example.com/image.png'
        }
      )
    end

    let(:invalid_auth) do
      OmniAuth::AuthHash.new(
        provider: 'google_oauth2',
        uid: '12345',
        info: { email: '', name: '' }
      )
    end

    context I18n.t('rspec.contexts.invalid_auth_data') do
      it I18n.t('rspec.raises_error_does_not_save_user') do
        expect { User.from_omniauth(invalid_auth) }
          .to raise_error(StandardError, I18n.t('rspec.errors.failed_to_create_user'))
      end
    end

    context I18n.t('rspec.contexts.existing_user') do
      let!(:user) { create(:user, email: 'test@example.com') }

      it I18n.t('rspec.returns_existing_user_updates_provider_uid') do
        result = User.from_omniauth(auth_hash)
        expect(result).to eq(user)
        expect(result.provider).to eq('google_oauth2')
        expect(result.uid).to eq('12345')
      end
    end

    context I18n.t('rspec.contexts.new_user') do
      it I18n.t('rspec.creates_new_user') do
        expect { User.from_omniauth(auth_hash) }.to change(User, :count).by(1)
        user = User.last
        expect(user.email).to eq('test@example.com')
        expect(user.name).to eq('Test User')
        expect(user.image).to eq('http://example.com/image.png')
      end
    end

    context I18n.t('rspec.contexts.user_creation_fails') do
      it I18n.t('rspec.raises_error_does_not_save_user') do
        allow(User).to receive(:new).and_raise(StandardError, I18n.t('rspec.errors.failed_to_create_user'))
        expect do
          User.from_omniauth(auth_hash)
        end.to raise_error(StandardError, I18n.t('rspec.errors.failed_to_create_user'))
      end
    end
  end
end
