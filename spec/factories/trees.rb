FactoryBot.define do
  factory :tree do
    level { 0 }
    job { 'Seedlings' }
    points { 0 }
    max_count { 1 }
    association :user
  end
end
