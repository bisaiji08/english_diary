# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| I18n.t('factories.user.name', default: "Test User #{n}") }
    sequence(:email) { |n| I18n.t('factories.user.email', default: "user#{n}@example.com") }
    password { I18n.t('factories.user.password', default: 'password') }
  end
end
