class Kitchen <  ActiveRecord::Base
  belongs_to :brand, dependent: :destroy
  belongs_to :seller
  has_many :dishes
end
