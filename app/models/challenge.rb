class Challenge < ApplicationRecord
  belongs_to :user
  monetize :price_cents
  has_one :order, dependent: :destroy


  CHALLENGE_TYPE = ['KM', 'TIME']

  def all_activities_km
    distance = 0
    Activity.where('date_start > ? AND date_start < ? AND user_id = ?', start_date, start_date, user_id) do |a|
      distance += a.distance
    end
    puts distance
    return distance
  end

end
