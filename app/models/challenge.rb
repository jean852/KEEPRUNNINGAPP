class Challenge < ApplicationRecord
  belongs_to :user
  monetize :price_cents
  has_one :order, dependent: :destroy
  validates :name, presence: true
  validates :activity_type, presence: true
  validates :challenge_type, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true, comparison: { greater_than: :start_date }

  CHALLENGE_TYPE = ['KM', 'Sessions']

  def all_activities
    activities = Activity.where('start_date >= ? AND start_date <= ? AND user_id = ?', self.start_date, self.end_date, self.user_id ).sort_by { |a| a.start_date }.reverse
    return activities
  end

  def all_activities_km
    distance = 0
    activities = Activity.where("start_date >= ? AND start_date <= ? AND user_id = ? AND activity_type = 'KM'", self.start_date, self.end_date, self.user_id )
    activities.each do |a|
      distance += a.distance
    end
    distance = distance / 1000.00
    return distance
  end

  def all_activities_sessions
    activities = Activity.where("start_date >= ? AND start_date <= ? AND user_id = ? AND activity_type = 'Sessions'", self.start_date, self.end_date, self.user_id )
    return activities.count
  end

  def progress_text

    progress_distance = self.all_activities_km / target_distance
    progress_time = (Date.today - start_date).fdiv(end_date - start_date)

    delta = progress_distance - progress_time

    if delta >= 0
      return "On track"
    else
      return "You are late"
    end
  end
end
