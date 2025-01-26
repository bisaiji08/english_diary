# frozen_string_literal: true

class Tree < ApplicationRecord
  belongs_to :user
  has_many :purchases, through: :user
  validates :level, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :job, presence: true
  validates :points, numericality: { greater_than_or_equal_to: 0 }
  validates :max_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :user_id, uniqueness: true

  after_initialize :set_defaults, if: :new_record?

  def self.ransackable_attributes(_auth_object = nil)
    %w[id level points job last_trained_at max_count created_at updated_at user_id]
  end

  def set_defaults
    self.level ||= 0
    self.job ||= 'Seedlings'
    self.points ||= 0
    self.max_count ||= 1
  end

  def can_train?
    return false if last_trained_at && last_trained_at.to_date == Date.today

    true
  end

  def train!
    raise I18n.t('trees.train.not_allowed') unless can_train?

    if job == 'mature tree' && level >= 10
      reset_tree
    elsif level >= 10
      promote_job
    else
      self.level += 1
    end
    self.last_trained_at = Time.current
    save! # 確実に保存する
  end

  def purchase_item(item)
    return I18n.t('trees.purchase.not_enough_points', item_name: item.name) unless self.points >= item.price

    self.points -= item.price
    save!
    # アイテムの購入記録を作成（ログや所有リストに追加する場合など）
    I18n.t('trees.purchase.success', item_name: item.name)
  end

  private

  def promote_job
    case job
    when 'Seedlings'
      self.job = 'young tree'
    when 'young tree'
      self.job = 'mature tree'
    end
    self.level = 0
  end

  def reset_tree
    self.job = 'Seedlings'
    self.level = 0
    self.points += 500
    self.max_count += 1
  end
end
