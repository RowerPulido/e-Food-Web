class Payment < ApplicationRecord
  belongs_to :client, dependent: :destroy
end
