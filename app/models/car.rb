class Car < ApplicationRecord
    belongs_to :user, optional: true
    has_rich_text :content

    validate :content
    validates :engine, :year,:fuel_type,:brand, :model, presence: true
end
