# frozen_string_literal: true

FactoryBot.define do
  factory :diary do
    title { I18n.t('factories.diary.title', default: 'Test Diary') }
    content_japanese { I18n.t('factories.diary.content_japanese', default: 'こんにちは') }
    content_english { I18n.t('factories.diary.content_english', default: 'Hello') }
    japanese_font_name { I18n.t('factories.diary.japanese_font_name', default: 'Noto Sans JP') }
    english_font_name { I18n.t('factories.diary.english_font_name', default: 'Noto Sans') }
    association :user
  end
end
