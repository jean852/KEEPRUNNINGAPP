class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

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

  def webhook(req,res)
    # Your verify token. Should be a random string.
    VERIFY_TOKEN = "STRAVA"
    # Parses the query params
    @mode = req.query['hub.mode']
    @token = req.query['hub.verify_token']
    @challenge = req.query['hub.challenge']
    # Checks if a token and mode is in the query string of the request
    if (@mode && @token)
      # Verifies that the mode and token sent are valid
      if (@mode == 'subscribe' && @token == VERIFY_TOKEN)
        # Responds with the challenge token from the request
        puts ('WEBHOOK_VERIFIED')
        res.json({"hub.challenge":challenge})
      else
        # Responds with '403 Forbidden' if verify tokens do not match
        res.sendStatus(403)
      end
    end
    puts "Finished def Webhook"
  end
end
