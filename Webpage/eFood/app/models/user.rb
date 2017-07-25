class User < ApplicationRecord
  has_many :clients
  has_many :sellers
  before_save { self.email = email.downcase } 
  before_save { self.name = name.capitalize }
  before_save { self.last_name = last_name.capitalize }
  validates :username, presence: true, uniqueness: { case_sensitive: true }, length: { minimum: 3, maximum: 25 } 
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true,uniqueness: { case_sensitive: true }, format: { with: VALID_EMAIL_REGEX }
 
  has_secure_password
end
