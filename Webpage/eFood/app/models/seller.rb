class Seller <  ActiveRecord::Base
  belongs_to :user
  has_one :kitchen
  has_one :brand
end
