class Dish < ApplicationRecord
  belongs_to :seller, dependent: :destroy
  has_many :evaluations, dependent: :destroy
  has_many :comments, dependent: :destroy
end
