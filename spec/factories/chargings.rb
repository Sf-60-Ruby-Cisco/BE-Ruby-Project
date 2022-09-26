FactoryBot.define do
  factory :charging do
    brand_station { "OMV "}
    date { Date.today }
    amount_cents { 40000 }
    car
  end
end