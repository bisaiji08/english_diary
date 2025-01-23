# frozen_string_literal: true

class Diary < ApplicationRecord
  belongs_to :user
  validates :title, presence: true

  validates :japanese_font_name, presence: true, allow_blank: true
  validates :english_font_name, presence: true, allow_blank: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id title content_japanese content_english start_time font_name japanese_font_name
       english_font_name user_id created_at updated_at]
  end

  def japanese_font_name
    super || 'Noto Sans JP'
  end

  def english_font_name
    super || 'Noto Sans'
  end
end
