class Dish < ApplicationRecord
  belongs_to :kitchen, dependent: :destroy
  has_many :evaluations, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :dishes_tags 
	has_many :tags, through: :dishes_tags
end
