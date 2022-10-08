FactoryBot.define do
  sequence :title do |n|
    "MyString-#{n}"
  end

  factory :question do
    title
    body { "MyText" }
    association :user

    trait :invalid do
     title { nil }
    end

    trait :created_at_yesterday do
      created_at { Date.yesterday }
    end

    trait :created_at_last do
      created_at { Date.today - 2 }
    end
  end
end
