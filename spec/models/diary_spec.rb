require 'rails_helper'

RSpec.describe Diary, type: :model do
  describe 'バリデーション' do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe 'アソシエーション' do
    it { is_expected.to belong_to(:user) }
  end

  describe '#japanese_font_name' do
    it 'デフォルト値を返す' do
      diary = build(:diary, japanese_font_name: nil)
      expect(diary.japanese_font_name).to eq('Noto Sans JP')
    end
  end
end
