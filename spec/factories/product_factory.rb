FactoryGirl.define do
  factory :product do
    name Faker::Commerce.product_name
    description  Faker::Lorem.characters(140)
    price Faker::Commerce.price
    association :shop
    quantity Faker::Number.number(3)
  end
end
