# frozen_string_literal: true

FactoryBot.define do
  factory :repair do    
    description { Faker::Lorem.paragraph}
    amount_cents { Faker::Number.between(from: 100, to: 100000) }
    # amount_currency { 'USD' }
    date { Faker::Date.between(from: '2020-01-01', to: Time.now)}
    association :car       
  end
end