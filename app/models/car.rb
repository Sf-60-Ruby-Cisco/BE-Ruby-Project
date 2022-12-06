class Car < ApplicationRecord    

  belongs_to :user
  has_many :repairs, dependent: :delete_all
  has_many :chargings, dependent: :delete_all
  has_many :taxes, dependent: :delete_all
  has_many :expenses, dependent: :delete_all
  has_one_attached :content do |attachable|
    attachable.variant :thumb, resize_to_limit: [300, 300]
  end

  scope :total_items,        lambda { | date_start=nil, date_end=nil, items=nil | joins(items).group_by_month(:date, format: "%B %Y", range: date_start..date_end).sum('amount_cents/100')}
  scope :all_car_items,      lambda { | date_start=nil, date_end=nil, items=nil | joins(items).group(:created_at, :license_plate).group_by_month(:date, format: "%B %Y", range: date_start..date_end).sum('amount_cents/100')}

  scope :total_items_year,   lambda { | date_start=nil, date_end=nil, items=nil | joins(items).group_by_year(:date, format: "%Y", range: date_start..date_end).sum('amount_cents/100')}
  scope :all_car_items_year, lambda { | date_start=nil, date_end=nil, items=nil | joins(items).group(:created_at, :license_plate).group_by_year(:date, format: "%Y", range: date_start..date_end).sum('amount_cents/100')}

  paginates_per 3


  validates_with TypeValidator
  validate :content
  validates :engine, :year,:fuel_type,:brand, :model, presence: true, length: {maximum: 20}
  validates :license_plate, presence: true, length: { in: 6..8 }


end
