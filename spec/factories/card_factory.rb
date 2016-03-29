FactoryGirl.define do
  factory :card do
    stripe_customer_id Faker::Lorem.characters(18)
    stripe_card_id Faker::Lorem.characters(29)
    card_brand Faker::Business.credit_card_type
    card_last_4 Faker::Number.number(4)
    association :user
  end
end
