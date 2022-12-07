class RefreshtokenJob < ApplicationJob
  queue_as :default

  def perform(user)
    # Do something later
    puts "I'm starting the job for user: #{user.profile.first_name}"
    oauth_client ||= Strava::OAuth::Client.new(
      client_id: ENV.fetch('STRAVA_CLIENT_ID', nil),
      client_secret: ENV.fetch('STRAVA_CLIENT_SECRET', nil)
    )

    if user.sl_access_token.expires_at && Time.now + 1.hour < user.sl_access_token.expires_at
      return
    else

      response = oauth_client.oauth_token(
        refresh_token: user.refresh_token.refresh_token_code,
        grant_type: 'refresh_token'
      )
      # puts "This is the response we get from Strava for Token Refresh"
      # puts response

      # puts "This is the old token entry"
      # puts SlAccessToken.find_by user_id: user.id
      slaccesstoken = SlAccessToken.find_by user_id: user.id
      slaccesstoken.sl_access_token_code = response.access_token
      slaccesstoken.expires_at = Time.at(response.expires_at)
      # puts "This is the new token entry"
      # puts slaccesstoken.sl_access_token_code
      # puts slaccesstoken.expires_at
      slaccesstoken.save!
    end
    puts "Access Token Refresh process done now"
  end
end
