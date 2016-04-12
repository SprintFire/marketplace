FactoryGirl.define do
  factory :withdrawal do
    amount Faker::Number.decimal(1,2)
    approved Faker::Boolean.boolean
    association :shop
  end
end
