class Activity < ApplicationRecord
  belongs_to :user,
    class_name: '::User',
    foreign_key: 'user_id'


  validates :strava_id, uniqueness: true
end
