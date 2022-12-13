class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

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
    puts "From webhook"
  end



end
