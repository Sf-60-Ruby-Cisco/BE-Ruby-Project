class Expense < ApplicationRecord
	belongs_to :car
	monetize :price_cents
	# monetize :price_cents
end
