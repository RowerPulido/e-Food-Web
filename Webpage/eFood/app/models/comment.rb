class Comment < ApplicationRecord
  belongs_to :client, dependent: :destroy
  belongs_to :dishes, dependent: :destroy
  validates :comment, presence: true, uniqueness: { case_sensitive: true }, length: { maximum: 140 } 
end
