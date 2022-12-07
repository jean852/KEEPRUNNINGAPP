class Profile < ApplicationRecord
  belongs_to :user
  validates :user_id, uniqueness: true

  def self.create_profile_from_strava(provider_data, user)
    where(user_id: user.id).first_or_create do |profile|
      profile.user_id = user.id
      puts provider_data
      profile.first_name = provider_data.athlete.firstname
      profile.last_name = provider_data.athlete.lastname
      profile.username = provider_data.athlete.username
      profile.sex = provider_data.athlete.sex
      profile.profile_url = provider_data.athlete.profile
      profile
    end
  end
end
