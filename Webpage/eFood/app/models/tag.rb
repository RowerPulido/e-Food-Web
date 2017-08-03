class Tag < ActiveRecord::Base
  has_many :dishes_tags
  has_many :dishes, through: :dishes_tags
end
