class Address < ApplicationRecord
  belongs_to :clients, dependent: :destroy
end
