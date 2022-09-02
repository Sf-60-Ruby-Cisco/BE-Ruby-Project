class TypeValidator < ActiveModel::Validator
  
  def validate(record)
    return unless record.content.attached?   
    unless record.content.content_type.in?(%w[image/png image/jpeg image/jpg image/gif])
      record.errors.add(:You, "can only upload jpg, png ang gif files!")
    end
  end
end