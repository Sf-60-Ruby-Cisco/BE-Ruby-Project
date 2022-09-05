class Repair < ApplicationRecord
  belongs_to :car
  monetize :amount_cents, numericality: { in: 0..4294967295 }
  has_one_attached :content
  validates_with TypeValidator
end