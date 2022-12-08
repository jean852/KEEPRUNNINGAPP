class Challenge < ApplicationRecord
  belongs_to :user
  ACTIVITY_TYPE = ['RUNNING', 'CYCLING']
end
