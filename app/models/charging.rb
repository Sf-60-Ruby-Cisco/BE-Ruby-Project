class Charging < ApplicationRecord
  belongs_to :car
  validates :amount, numericality: {greater_than: 0}
end