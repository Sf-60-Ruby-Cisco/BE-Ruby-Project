class Tax < ApplicationRecord
  DAYS_AGO_DUE_TAXES = 351
  scope :due_taxes, -> { where(date: DAYS_AGO_DUE_TAXES.days.ago.to_date) }
  
  belongs_to :car
  monetize :amount_cents, numericality: { in: 0.01..4294967295 }
  validates :description, length: {maximum: 350}
  validates :tax_type, presence: true, length: { in: 3..100 }
end