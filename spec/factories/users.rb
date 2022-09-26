# frozen_string_literal: true


FactoryBot.define do
  factory :user do
    email { Faker::Internet.email}
    username {Faker::Internet.username(specifier: 5..10) }
    password {'123456'}
    password_confirmation {'123456'}
    confirmed_at { Time.now }       
  end 
end