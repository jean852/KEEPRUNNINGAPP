class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :webhook, :handle_activities]
  skip_before_action :verify_authenticity_token

  def dashboard
    @challenges = Challenge.where('user_id = ?', current_user.id)
    @activities = Activity.where('user_id = ?', current_user.id)
    @activities.sort_by { |a| a.start_date }
    @top5 = []
    @top5 << @activities.first unless @activities.first.nil?
    @top5 << @activities.second unless @activities.second.nil?
    @top5 << @activities.third unless @activities.third.nil?
    @top5 << @activities.fourth unless @activities.fourth.nil?
    @top5 << @activities.fifth unless @activities.fifth.nil?

    now = Date.today
    thirty_days_ago = (now - 30)

    @lastmonthactivities = Activity.where('user_id = ? AND start_date > ?', current_user.id, thirty_days_ago)
    @last_month_distance_m = 0
    @lastmonthactivities.each do |a|
      @last_month_distance_m += a.distance
    end


    # @challenge.all_activities_km
  end

  def leaderboard
    @profiles = Profile.all
  end

  def webhook
    puts "Finished def Webhook"
    render json: {"hub.mode": 'subscribe', "hub.challenge": params['hub.challenge'], "hub.verify_token": 'STRAVA' }
  end

  def handle_activities
    puts params
    userwh = User.find_by athlete_id: params["owner_id"]

    slaccesstoken = SlAccessToken.find_by user_id: userwh.id
    puts "this is the access token #{slaccesstoken.sl_access_token_code}"

    client = Strava::Api::Client.new(
      access_token: slaccesstoken.sl_access_token_code
    )
    puts "this is the activity id #{params['object_id']}"

    if params["aspect_type"] == "create" && params["object_type"] == "activity"
      puts "entering the create loop"
      # get the activity
      activity = client.activity(params["object_id"])
      # create new activity
      newactivity = Activity.new
      newactivity.strava_id = params["object_id"]
      newactivity.user_id = userwh.id
      newactivity.name = activity.name
      newactivity.distance = activity.distance
      newactivity.moving_time = activity.moving_time
      newactivity.elapsed_time = activity.elapsed_time
      newactivity.activity_type = activity.type
      newactivity.start_date = activity.start_date
      newactivity.average_speed = activity.average_speed
      newactivity.save!
    elsif params["aspect_type"] == "delete" && params["object_type"] == "activity"
      puts "entering the delete loop"
      activity_to_delete = Activity.find_by strava_id: params["object_id"]
      activity_to_delete.destroy
      puts "Activity #{params['object_id']} has been destroyed"
    else
    end
  end

end
