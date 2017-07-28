class Brand < ActiveRecord::Base
   has_many :branch_offices
   belongs_to :seller
end
