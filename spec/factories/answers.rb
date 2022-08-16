FactoryBot.define do
  sequence :body do |n|
    "MyText-#{n}"
  end

  factory :answer do
    body
    association :question
    association :user

    trait :invalid do
     body { nil }
    end
  end
end
