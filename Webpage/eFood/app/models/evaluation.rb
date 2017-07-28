class Evaluation <  ActiveRecord::Base
  belongs_to :client, dependent: :destroy
  belongs_to :dishes, dependent: :destroy
end
