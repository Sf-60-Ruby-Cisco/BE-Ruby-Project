# frozen_string_literal: true

FactoryBot.define do
  factory :repair do    
    description { Faker::Lorem.paragraph}
    amount { Faker::Number.between(from: 100, to: 100000) }
    date { Faker::Date.between(from: '2020-01-01', to: Time.now)}
    association :car       
  end
end
