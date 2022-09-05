class User < ApplicationRecord  
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
   
  attr_writer :login       
  has_many :cars  
  validate :validate_username, :content
  validates_uniqueness_of :username, :email
  has_one_attached :content do |attachable|
    attachable.variant :thumb, resize_to_limit: [46, 46]
  end
  
  validates_with TypeValidator
  validates :password, length: { minimum: 6, maximum: 20 }, on: :create
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, length: {maximum: 320} 
  validates :username, presence: true, length: { in: 3..40 }, format: { with: /\A[a-zA-Z0-9]+\z/, on: :create }  
   

  def login
    @login || self.username || self.email
  end

  # Use login for username and email
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  # Soft deleting user making it deactive  
  def destroy
    update_attribute(:deactivated, true) unless deactivated
    update_attribute(:email, nil) 
    update_attribute(:username, nil) 
  end  

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end  

  # Stoping the user from loggin when deactivated
  def active_for_authentication?
    super && !deactivated
  end  

  private

  # def username_length     
  #   return unless username.length < 3 || username.length > 40
  #   errors.add(:username, "must be between 3 and 40 characters")
  #   end
end

