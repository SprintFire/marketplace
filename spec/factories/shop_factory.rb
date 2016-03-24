FactoryGirl.define do
  factory :shop do
    name Faker::Company.name
    description  Faker::Lorem.paragraph(15)
    association :user
    facebook_url Faker::Internet.url('facebook.com')
    twitter_username Faker::Internet.url('twitter.com')
    instagram_username Faker::Internet.url('instagram.com')
    contact_phone Faker::PhoneNumber.phone_number
    email_id Faker::Internet.email
    longitude Faker::Address.longitude
    latitude Faker::Address.latitude
    profile_image Faker::Avatar.image
    header_image Faker::Avatar.image
    address Faker::Address.street_address
  end
end
