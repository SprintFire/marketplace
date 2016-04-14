FactoryGirl.define do
  factory :withdrawal do
    amount Faker::Number.number(3)
    approved Faker::Boolean.boolean
    association :shop
  end
end
