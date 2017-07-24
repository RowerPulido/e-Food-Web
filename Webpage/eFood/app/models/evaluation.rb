class Evaluation < ApplicationRecord
  has_many :clients, dependent: :destroy
  has_many :dishes, dependent: :destroy
end
