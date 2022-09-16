class Charging < ApplicationRecord
  belongs_to :car
  monetize :amount_cents, numericality: { greater_than: 0 }
end