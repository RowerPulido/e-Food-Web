class Client < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :payments,  dependent: :destroy
  has_many :addresses,  dependent: :destroy
  has_many :comments
  has_many :evaluations
  has_many :orders
end
