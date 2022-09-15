class Car < ApplicationRecord    

  belongs_to :user
  has_many :repairs, dependent: :delete_all
  has_many :chargings, dependent: :delete_all
  
  has_one_attached :content do |attachable|
      attachable.variant :thumb, resize_to_limit: [300, 300]
  end

  scope :total_repairs, -> {joins(:repairs).group_by_month(:date, format: "%B %Y").sum(:amount_cents)}
  scope :total_chargings, -> {joins(:chargings).group_by_month(:date, format: "%B %Y").sum(:amount_cents)}
  paginates_per 3


  validates_with TypeValidator
  validate :content
  validates :engine, :year,:fuel_type,:brand, :model, presence: true, length: {maximum: 20}
  validates :license_plate, presence: true, length: { in: 6..8 }
    
end
