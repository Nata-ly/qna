FactoryBot.define do
  factory :link do
    name { "MyString" }
    url { "http://MyString.com" }
    association :linkable
  end
end
