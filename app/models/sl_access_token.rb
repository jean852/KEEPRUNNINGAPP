class SlAccessToken < ApplicationRecord
  belongs_to :user


  def self.create_sl_access_token_from_strava(provider_data, user)

    where(user_id: user.id).first_or_create do |slaccesstoken|

      slaccesstoken.user_id = user.id
      slaccesstoken.athlete_id = provider_data.athlete.id
      slaccesstoken.scope = true
      slaccesstoken.sl_access_token_code = provider_data.access_token
      slaccesstoken.expires_at = provider_data.expires_at
      slaccesstoken
    end
  end

end
