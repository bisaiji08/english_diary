# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe 'アソシエーション' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:item) }
  end

  describe '.fonts_for_user' do
    let(:user) { create(:user) }
    let(:font_item) { create(:item, category: 'Font') }
    let!(:purchase) { create(:purchase, user: user, item: font_item) }

    it '指定されたユーザーのフォントを返す' do
      expect(Purchase.fonts_for_user(user)).to include(font_item)
    end
  end
end
