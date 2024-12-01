class Item < ApplicationRecord
  has_many :purchases
  has_many :users, through: :purchases
  
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
