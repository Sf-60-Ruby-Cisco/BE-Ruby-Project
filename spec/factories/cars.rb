FactoryBot.define do
  factory :car do
    sequence(:brand) { |n| "Brand#{n}" }
    sequence(:model) { |n| "Model#{n}" }
    sequence(:engine) { |n| "Engine#{n}" }
    sequence(:fuel_type) { |n| "FuelType#{n}" }
    sequence(:license_plate) { |n| "Plate#{n}" }
    year { Date.today }
    user
  end
end