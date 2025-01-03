class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :item

  def self.fonts_for_user(user)
    joins(:item).where(user: user, items: { category: 'Font' }).map(&:item)
  end
end
