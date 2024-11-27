class Tree < ApplicationRecord
  belongs_to :user
  has_many :purchases, through: :user
  validates :level, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :job, presence: true
  validates :points, numericality: { greater_than_or_equal_to: 0 }
  validates :max_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :user_id, uniqueness: true

  after_initialize :set_defaults, if: :new_record?

  def set_defaults
    self.level ||= 0
    self.job ||= "Seedlings"
    self.points ||= 0
    self.max_count ||= 1
  end

  # 特訓ができるかどうかをチェック
  def can_train?
    return false if self.last_trained_at && self.last_trained_at.to_date == Date.today
    true
  end

  # 特訓処理
  def train!
    if job == "mature tree" && level >= 10
      reset_tree
    elsif level >= 10
      promote_job
    else
      increment(:level)
    end
    save
  end

  def purchase_item(item)
    if self.points >= item.price
      self.points -= item.price
      self.save!
      # アイテムの購入記録を作成（ログや所有リストに追加する場合など）
      return "Item '#{item.name}' purchased successfully!"
    else
      return "Not enough points to purchase '#{item.name}'."
    end
  end

  private

  def promote_job
    case job
    when "Seedlings"
      self.job = "young tree"
    when "young tree"
      self.job = "mature tree"
    end
    self.level = 0
  end

  def reset_tree
    self.job = "Seedlings"
    self.level = 0
    self.points += 500
    self.max_count += 1
  end
end
