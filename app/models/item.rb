class Item < ApplicationRecord
  has_many :purchases
  has_many :users, through: :purchases

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :category, presence: true

  scope :shop_items, -> { where.not(font_name: ['Noto Sans', 'Noto Sans JP']) }
end
