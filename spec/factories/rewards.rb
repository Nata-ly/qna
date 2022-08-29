FactoryBot.define do
  factory :reward do
    title { 'Title' }
    association :user
    association :question

    trait :invalid do
     title { nil }
    end
  end
end
