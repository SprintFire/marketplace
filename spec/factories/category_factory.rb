FactoryGirl.define do
  factory :category do
    title Faker::Company.name
    description  Faker::Lorem.paragraph(5)
  end
end
