class TypeValidator < ActiveModel::Validator
  
  def validate(record)
    return unless record.content.attached?   
    unless record.content.content_type.in?(%w[image/png image/jpeg image/jpg image/gif application/pdf])
      record.errors.add(:You, "can only upload jpg, png, gif and pdf files!")
    end
  end
end