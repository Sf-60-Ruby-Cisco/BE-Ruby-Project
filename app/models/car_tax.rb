class CarTax < ApplicationRecord
  belongs_to :car
  belongs_to :tax
end
