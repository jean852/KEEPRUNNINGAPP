class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home,:webhook,:handle_activities]
  skip_before_action :verify_authenticity_token

  def home

  end

  def dashboard
    @challenges = Challenge.where('user_id = ?', current_user.id)
    @activities = Activity.where('user_id = ?', current_user.id)
    @top5 = []
    @top5 << @activities.first
    @top5 << @activities.second
    @top5 << @activities.third
    @top5 << @activities.fourth
    @top5 << @activities.fifth

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
  puts "Can go before put param"

  puts params
  newactivity = Activity.new
  puts "Can go after put param"
  puts newactivity
  newactivity.strava_id =  params["object_id"]
  newactivity.user_id =params["owner_id"]
  puts newactivity.strava_id
  puts newactivity.user_id
  puts "checked 2 first params"

  newactivity.name = "hello"
  newactivity.distance = 3
  newactivity.moving_time = 123
  newactivity.elapsed_time = 333
  #newactivity.activity_type = "run hello"
  newactivity.start_date = "01/01/2022"
  newactivity.average_speed = 123

  newactivity.save!

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
