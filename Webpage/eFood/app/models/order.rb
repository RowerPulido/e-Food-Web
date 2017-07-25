class Order < ApplicationRecord
  belongs_to :client, dependent: :destroy
  has_many :order_details
  has_many :dishes, through: :order_details
end