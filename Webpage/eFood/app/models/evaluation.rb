class Evaluation <  ActiveRecord::Base
  belongs_to :client
  belongs_to :dish
  validates :calification, presence: true, length: { minimum: 0, maximum: 5 } 
end
