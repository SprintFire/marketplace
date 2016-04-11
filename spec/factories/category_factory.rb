FactoryGirl.define do
  factory :category do
    title Faker::Commerce.department(1, true)
    description  Faker::Lorem.paragraph(5)
  end
end
