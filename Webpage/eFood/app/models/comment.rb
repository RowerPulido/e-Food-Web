class Comment <   ActiveRecord::Base
  belongs_to :client, dependent: :destroy
  belongs_to :dish, dependent: :destroy
  validates :comment, presence: true, uniqueness: { case_sensitive: true }, length: { minimum: 3, maximum: 140 } 
end
