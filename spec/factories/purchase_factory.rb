FactoryGirl.define do
  factory :purchase do
    price Faker::Commerce.price
    quantity Faker::Number.number(3)
    shop_profit Faker::Number.number(4)
    association :user
    association :product
  end
end
