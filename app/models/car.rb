class Car < ApplicationRecord
  has_many :car_taxes
  has_many :taxes, through: :car_taxes

  belongs_to :user
  has_many :chargings
  has_one_attached :content do |attachable|
      attachable.variant :thumb, resize_to_limit: [300, 300]
  end

  validates_with TypeValidator
  validate :content
  validates :engine, :year,:fuel_type,:brand, :model, presence: true, length: {maximum: 20}
  validates :license_plate, length: {maximum: 10}
end
