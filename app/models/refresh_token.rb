class RefreshToken < ApplicationRecord
  belongs_to :user
  validates :user_id, uniqueness: true

  def self.create_refresh_token_from_strava(provider_data, user)
    where(user_id: user.id).first_or_create do |refreshtoken|
      refreshtoken.user_id = user.id
      refreshtoken.refresh_token_code = provider_data.refresh_token
      refreshtoken.scope = true
      refreshtoken
    end
  end

end
