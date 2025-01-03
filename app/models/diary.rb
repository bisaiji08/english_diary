class Diary < ApplicationRecord
  belongs_to :user
  validates :title, presence: true

  validates :japanese_font_name, presence: true, allow_blank: true
  validates :english_font_name, presence: true, allow_blank: true

  def japanese_font_name
    super || 'Noto Sans JP'
  end
  
  def english_font_name
    super || 'Noto Sans'
  end
end
