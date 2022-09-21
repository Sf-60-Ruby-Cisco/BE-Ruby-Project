class Charging < ApplicationRecord
  belongs_to :car
  monetize :amount_cents, numericality: { in: 0.01..4294967295 }
end