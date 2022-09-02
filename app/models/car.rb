class Car < ApplicationRecord
	belongs_to :user
	has_many :car_taxes
	has_many :taxes, through: :car_taxes
end
