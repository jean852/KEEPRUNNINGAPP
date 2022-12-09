class Challenge < ApplicationRecord
  belongs_to :user
  CHALLENGE_TYPE = ['KM', 'TIME']
end
