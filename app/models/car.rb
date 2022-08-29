class Car < ApplicationRecord
    

  belongs_to :user, optional: true
  has_one_attached :content do |attachable|
      attachable.variant :thumb, resize_to_limit: [300, 300]
  end

  validate :content, :validate_filetypes
  validates :engine, :year,:fuel_type,:brand, :model, presence: true, length: {maximum: 20}
  validates :license_plate, length: {maximum: 10}

  private 

  def validate_filetypes
    return unless content.attached?   
    unless content.content_type.in?(%w[image/png image/jpeg image/jpg image/gif])
      errors.add(:You, "can only upload jpg, png ang gif files!")
    end
  end
    
end
