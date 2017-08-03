class User <  ActiveRecord::Base
  has_many :clients, dependent: :destroy
  has_many :sellers, dependent: :destroy
  before_save { self.email = email.downcase } 
  before_save { self.name = name.capitalize }
  before_save { self.last_name = last_name.capitalize }
  validates :cellphone, presence: true, uniqueness: { case_sensitive: true }, length: { minimum: 7, maximum: 10 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, uniqueness: { case_sensitive: true }, format: { with: VALID_EMAIL_REGEX }
 
  has_secure_password
end
