class Brand < ActiveRecord::Base
   has_many :kitchens
   belongs_to :seller
end
