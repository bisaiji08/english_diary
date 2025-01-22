require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'バリデーション' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end

  describe 'アソシエーション' do
    it { is_expected.to have_many(:purchases) }
    it { is_expected.to have_many(:users).through(:purchases) }
  end

  describe '.shop_items' do
    let!(:default_item) { create(:item, font_name: 'Noto Sans') }
    let!(:shop_item) { create(:item, font_name: 'Custom Font') }

    it '販売可能なアイテムを返す' do
      expect(Item.shop_items).to include(shop_item)
      expect(Item.shop_items).not_to include(default_item)
    end
  end
end
