FactoryGirl.define do
  factory :user do
    name { Faker::Lorem.sentence }
    address { Faker::Lorem.paragraph }
    hobbies { Faker::Lorem.paragraph }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }
  end
end
