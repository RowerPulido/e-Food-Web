class DishesTag <  ActiveRecord::Base
  belongs_to :tag
  belongs_to :dish
end
