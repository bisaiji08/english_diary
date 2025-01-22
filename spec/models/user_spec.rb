require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it '有効なユーザーが作成できる' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'メールアドレスが空の場合、無効である' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'メールアドレスが一意であること' do
      create(:user, email: 'test@example.com')
      user = build(:user, email: 'test@example.com')
      expect(user).not_to be_valid
    end
  end

  describe 'アソシエーション' do
    it { is_expected.to have_many(:diaries) }
    it { is_expected.to have_one(:tree).dependent(:destroy) }
    it { is_expected.to have_many(:purchases) }
    it { is_expected.to have_many(:purchased_items).through(:purchases) }
  end

  describe 'クラスメソッド' do
    describe '.ransackable_attributes' do
      it '検索可能な属性を返す' do
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

      it '新しいユーザーを作成する' do
        expect { User.from_omniauth(auth) }.to change(User, :count).by(1)
      end

      it '既存のユーザーを返す' do
        user = create(:user, email: 'test@example.com', provider: 'google_oauth2', uid: '12345')
        expect(User.from_omniauth(auth)).to eq(user)
      end
    end
  end
end
