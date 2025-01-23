# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { 'Test Item' }
    price { 100 }
    category { 'Font' }
  end
end
