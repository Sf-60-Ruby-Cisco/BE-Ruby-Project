# frozen_string_literal: true

FactoryBot.define do
  factory :car do    
    brand { Faker::Vehicle.make }
    model { Faker::Vehicle.model(make_of_model: brand) }
    engine { Faker::Vehicle.engine }
    fuel_type { Faker::Vehicle.fuel_type[1..20] }
    year { Faker::Date.between(from: '1990-01-01', to: Time.now)}
    license_plate { Faker::Vehicle.license_plate }
    association :user        
  end
end
