class Repair < ApplicationRecord
  belongs_to :car
  monetize :amount_cents, numericality: { greater_than: 0 }
  has_one_attached :content
end
