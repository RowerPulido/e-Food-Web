class BranchOffice < ApplicationRecord
  belongs_to :brand, dependent: :destroy
  belongs_to :seller
end
