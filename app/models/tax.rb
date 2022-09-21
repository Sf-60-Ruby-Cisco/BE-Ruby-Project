class Tax < ApplicationRecord
  belongs_to :car
  monetize :amount_cents, numericality: { in: 0.01..4294967295 }
  validates :description, length: {maximum: 350}

  # Class method
  def self.due_taxes
    where("date + 365 = ?", 14.days.from_now.to_date)
  end
end