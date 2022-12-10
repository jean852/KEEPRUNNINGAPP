class GetUserActivitiesJob < ApplicationJob
  queue_as :default

  def perform(user)
    # Do something later
      # Do something later
      puts "I'm starting the job for user: #{user.id}"
      puts "Token used is #{user.sl_access_token.sl_access_token_code}"
      # create client
      client = Strava::Api::Client.new(
        access_token: user.sl_access_token.sl_access_token_code
      )
      puts "Auth as #{client.athlete.id}"

      # Get list of activities
      activities = client.athlete_activities

      # Select the last 10 activities
      activities.each do |a|
        if Activity.where(strava_id: a.id.to_i).present? == true
          puts "Activity #{a.id} already exist in DB"
        elsif ["Ride", "Run"].include? a.type
          #we add it
          newactivity = Activity.new
          newactivity.strava_id = a.id.to_i
          newactivity.user_id = user.id
          newactivity.name = a.name
          newactivity.distance = a.distance
          newactivity.moving_time = a.moving_time
          newactivity.elapsed_time = a.elapsed_time
          newactivity.activity_type = a.type
          newactivity.start_date = a.start_date
          newactivity.average_speed = a.average_speed
          puts "Creation of Activity #{a.id} - #{a.name}"
          newactivity.save!
        else
          puts "Activity #{a.id} not supported by Keep Running"
        end
      end
      # Create activities if they do not exist in Activity DB




      # Lets try a specific activity
      # p client.activity(8220509334)

      # if user.sl_access_token.expires_at && Time.now + 1.hour < user.sl_access_token.expires_at
      #   return
      # else

      #   response = oauth_client.oauth_token(
      #     refresh_token: user.refresh_token.refresh_token_code,
      #     grant_type: 'refresh_token'
      #   )

      #   slaccesstoken = SlAccessToken.find_by user_id: user.id
      #   slaccesstoken.sl_access_token_code = response.access_token
      #   slaccesstoken.expires_at = Time.at(response.expires_at)
      #   slaccesstoken.save!
      # end
      puts "Activities fetched for user #{user.id}"

  end
end
