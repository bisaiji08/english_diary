# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe I18n.t('rspec.validations') do
    it I18n.t('rspec.can_create_valid_user') do
      user = build(:user)
      expect(user).to be_valid
    end

    it I18n.t('rspec.invalid_without_email') do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it I18n.t('rspec.unique_email') do
      create(:user, email: 'test@example.com')
      user = build(:user, email: 'test@example.com')
      expect(user).not_to be_valid
    end
  end

  describe I18n.t('rspec.associations') do
    it { is_expected.to have_many(:diaries) }
    it { is_expected.to have_one(:tree).dependent(:destroy) }
    it { is_expected.to have_many(:purchases) }
    it { is_expected.to have_many(:purchased_items).through(:purchases) }
  end

  describe I18n.t('rspec.class_methods') do
    describe '.ransackable_attributes' do
      it I18n.t('rspec.returns_searchable_attributes') do
        expect(User.ransackable_attributes).to include('email', 'name')
      end
    end

    describe '.from_omniauth' do
      let(:auth) do
        OmniAuth::AuthHash.new(
          provider: 'google_oauth2',
          uid: '12345',
          info: { email: 'test@example.com', name: 'Test User', image: 'image.jpg' }
        )
      end

      it I18n.t('rspec.creates_new_user') do
        expect { User.from_omniauth(auth) }.to change(User, :count).by(1)
      end

      it I18n.t('rspec.returns_existing_user') do
        user = create(:user, email: 'test@example.com', provider: 'google_oauth2', uid: '12345')
        expect(User.from_omniauth(auth)).to eq(user)
      end
    end
  end
end
