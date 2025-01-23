# frozen_string_literal: true

FactoryBot.define do
  factory :diary do
    title { 'Test Diary' }
    content_japanese { 'こんにちは' }
    content_english { 'Hello' }
    japanese_font_name { 'Noto Sans JP' }
    english_font_name { 'Noto Sans' }
    association :user
  end
end
