class User < ApplicationRecord
  has_many :clients, dependent: :destroy
  has_many :sellers, dependent: :destroy
  before_save { self.email = email.downcase } 
  validates :username, presence: true, uniqueness: { case_sensitive: true }, length: { minimum: 3, maximum: 25 } 
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true,uniqueness: { case_sensitive: true }, format: { with: VALID_EMAIL_REGEX }
 
  has_secure_password
end