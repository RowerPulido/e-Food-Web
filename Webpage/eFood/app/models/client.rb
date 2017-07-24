class Client < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :payments
  has_many :addresses
  has_many :comments
  has_many :evaluations
  has_many :orders
end
