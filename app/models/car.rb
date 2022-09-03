class Car < ApplicationRecord    

  belongs_to :user
  has_many :repairs, dependent: :delete_all
  has_many :chargings, dependent: :delete_all
  has_one_attached :content do |attachable|
      attachable.variant :thumb, resize_to_limit: [300, 300]
  end

  validates_with TypeValidator
  validate :content
  validates :engine, :year,:fuel_type,:brand, :model, presence: true, length: {maximum: 20}
  # Edited the min length as my car has 7 :D
  validates :license_plate, presence: true, length: { is: 7 }
    
end
