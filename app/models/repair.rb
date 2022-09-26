class Repair < ApplicationRecord
  belongs_to :car
  monetize :amount_cents, numericality: { in: 0.01..4294967295 }

  has_one_attached :content
  validates :description, presence: true, length: { in: 3..255 }
  validates :date, presence: true
  validates_with TypeValidator
end