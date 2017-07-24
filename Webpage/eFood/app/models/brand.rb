class Brand < ApplicationRecord
   has_many :branch_offices
   belongs_to :seller
end
