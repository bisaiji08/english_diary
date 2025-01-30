# frozen_string_literal: true

FactoryBot.define do
  factory :tree do
    level { I18n.t('factories.tree.level', default: 0) }
    job { I18n.t('factories.tree.job', default: 'Seedlings') }
    points { I18n.t('factories.tree.points', default: 0) }
    max_count { I18n.t('factories.tree.max_count', default: 1) }
    last_trained_at { nil } # 明示的に nil に設定
    association :user
  end
end
