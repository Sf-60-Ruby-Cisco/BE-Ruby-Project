FactoryBot.define do
  factory :user do
    email { Faker::Internet.email}
    username { Faker::Name.first_name }
    password {'123456'}
    password_confirmation {'123456'}
    confirmed_at { Time.now }       
  end 
end