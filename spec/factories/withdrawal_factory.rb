FactoryGirl.define do
  factory :withdrawal do
    amount Faker::Number.decimal(2)
    approved Faker::Boolean.boolean(0.2)
    association :shop
  end
end
