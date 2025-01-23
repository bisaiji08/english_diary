# frozen_string_literal: true

class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :item

  def self.ransackable_attributes(_auth_object = nil)
    %w[id user_id item_id created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user item]
  end

  def self.fonts_for_user(user)
    joins(:item).where(user: user, items: { category: 'Font' }).map(&:item)
  end
end
