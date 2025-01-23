# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.from_omniauth' do
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

    context 'when auth data is invalid' do
      it 'raises an error and does not save the user' do
        expect { User.from_omniauth(invalid_auth) }
          .to raise_error(StandardError, 'Failed to create user')
      end
    end

    context 'when user exists' do
      let!(:user) { create(:user, email: 'test@example.com') }

      it 'returns the existing user and updates provider/uid if necessary' do
        result = User.from_omniauth(auth_hash)
        expect(result).to eq(user)
        expect(result.provider).to eq('google_oauth2')
        expect(result.uid).to eq('12345')
      end
    end

    context 'when user does not exist' do
      it 'creates a new user' do
        expect { User.from_omniauth(auth_hash) }.to change(User, :count).by(1)
        user = User.last
        expect(user.email).to eq('test@example.com')
        expect(user.name).to eq('Test User')
        expect(user.image).to eq('http://example.com/image.png')
      end
    end

    context 'when user creation fails' do
      it 'raises an error and does not save the user' do
        allow(User).to receive(:new).and_raise(StandardError, 'Failed to create user')
        expect { User.from_omniauth(auth_hash) }.to raise_error(StandardError, 'Failed to create user')
      end
    end
  end
end
