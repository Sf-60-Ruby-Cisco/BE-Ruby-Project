class Tax < ApplicationRecord
  has_many :car_taxes
  has_many :cars, through: :car_taxes
end
