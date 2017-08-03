class Payment <  ActiveRecord::Base
  belongs_to :client, dependent: :destroy
end
