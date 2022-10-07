FactoryBot.define do
  sequence :url do |n|
    "http://MyString-#{n}.com"
  end

  factory :link do
    name { "MyString" }
    url
  end
end
