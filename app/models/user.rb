class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :diaries
  has_one :tree, dependent: :destroy

  after_create :create_tree

  has_many :purchases
  has_many :purchased_items, through: :purchases, source: :item

  def purchased_fonts
    purchased_items.where(category: 'Font')
  end

  private

  def create_tree
    self.create_tree!
  end

  def available_fonts
    # デフォルトフォントを追加して返す
    Item.where(font_name: ['Noto Sans', 'Noto Sans JP']) + purchased_fonts
  end
end
