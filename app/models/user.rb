class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
         
  has_many :cars
  attr_writer :login
  validate :validate_username, :content
  validates_uniqueness_of :username, :email
  has_rich_text :content
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :username, presence: true

   

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end  

  # Soft deleting user makin it deactive  
  def destroy
    update_attribute(:deactivated, true) unless deactivated
    update_attribute(:email, nil) 
    update_attribute(:username, nil) 
  end

  # Stoping the user from loggin when deactivated
  def active_for_authentication?
    super && !deactivated
  end
  
end
