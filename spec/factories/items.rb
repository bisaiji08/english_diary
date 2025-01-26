# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { I18n.t('factories.item.name', default: 'Test Item') }
    price { I18n.t('factories.item.price', default: 100) }
    category { I18n.t('factories.item.category', default: 'Font') }
  end
end
