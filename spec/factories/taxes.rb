# frozen_string_literal: true

FactoryBot.define do
  factory :tax do    
    description { Faker::Lorem.paragraph }
    amount { Faker::Number.between(from: 100, to: 100000) }
    date { Faker::Date.between(from: '2020-01-01', to: Time.now) }

    # .tr("\u0000", '') to escape error: ArgumentError (string contains null byte).
    # [ Rails/Postgres ] issue
    # https://github.com/faker-ruby/faker/issues/1596#issuecomment-481903436
    tax_type { Faker::String.random(length: 3..100).tr("\u0000", '') }
    association :car       
  end
end
