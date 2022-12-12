class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home,:webhook,:handle_activities]
  skip_before_action :verify_authenticity_token

  def home

  end

  def dashboard
    @challenges = Challenge.where('user_id = ?', current_user.id)
    @activities = Activity.where('user_id = ?', current_user.id)
    @activities.sort_by(&:start_date)
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

  end

  def leaderboard
    @profiles = Profile.all
  end

  def webhook
    # Your verify token. Should be a random string.
    # VERIFY_TOKEN = "STRAVA"
    puts "Finished def Webhook"
    render json: {"hub.mode": "subscribe", "hub.challenge": params["hub.challenge"], "hub.verify_token": "STRAVA"}
    # Parses the query params
  end

  def handle_activities
      userwh= User.find_by athlete_id: params["owner_id"]

      slaccesstoken = SlAccessToken.find_by user_id: userwh.id
      puts "this is the access token #{slaccesstoken.sl_access_token_code}"

      client = Strava::Api::Client.new(
      access_token: slaccesstoken.sl_access_token_code
      )

      puts "this is the activity id #{params["object_id"]}"
      puts params["object_id"]
      puts params["aspect_type"]
      puts params["object_type"]


      if params["aspect_type"] == "create" && params["object_type"] == "activity"
        puts "create loop"
        # get the activity
        activity = client.activity(params["object_id"])
        # create new activity
        newactivity = Activity.new
        newactivity.strava_id =  params["object_id"]
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
        puts "delte loop"
        activity_to_delete= Activity.find_by strava_id: params["object_id"]
        activity_to_delete.destroy
        puts "Activity #{params["object_id"]} has been destroyed"
      else
      end
  end
end

# GET https://mycallbackurl.com?hub.verify_token=STRAVA&hub.challenge=15f7d1a91c1f40f8a748fd134752feb3&hub.mode=subscribe
      # t.references :user, null: false, foreign_key: true
      # t.string :name
      # t.integer :distance
      # t.integer :moving_time
      # t.integer :elapsed_time
      # t.string :activity_type
      # t.date :start_date
      # t.float :average_speed
