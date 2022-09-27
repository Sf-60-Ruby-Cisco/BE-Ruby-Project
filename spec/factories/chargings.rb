FactoryBot.define do
  factory :charging do
    brand_station { "OMV "}
    date { Date.today }
    amount { 400 }
    car
  end
end