class Comment < ApplicationRecord
  has_many :clients, dependent: :destroy
  has_many :dishes, dependent: :destroy
  validates :comment, presence: true, uniqueness: { case_sensitive: true }, length: { maximum: 140 } 
end
