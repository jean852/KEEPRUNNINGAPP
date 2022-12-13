class Challenge < ApplicationRecord
  belongs_to :user
  monetize :price_cents

  CHALLENGE_TYPE = ['KM', 'TIME']
end
