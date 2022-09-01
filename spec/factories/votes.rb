FactoryBot.define do
  factory :vote do
    association :user
    association :votable
    solution { true }
  end
end
