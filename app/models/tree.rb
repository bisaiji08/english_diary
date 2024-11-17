class Tree < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :level, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :job, presence: true
  validates :points, numericality: { greater_than_or_equal_to: 0 }

  after_initialize :set_defaults, if: :new_record?

  def set_defaults
    self.level ||= 0
    self.job ||= "Seedlings"
    self.points ||= 0
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
  end
end
