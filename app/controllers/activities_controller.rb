class ActivitiesController < ApplicationController
  def index
    # skip_policy_scope
    @activities = policy_scope(Activity)
    # @activities = Activity.all
    @allactivities = Activity.where(["user_id = ?", current_user.id])
    @allactivities.sort_by { |a| a.start_date }.reverse

    @runningactivities = Activity.where(["user_id = ? AND activity_type = ?", current_user.id, "Run"])
    @runningactivities.sort_by { |a| a.start_date }.reverse

    @ridingactivities = Activity.where(["user_id = ? AND activity_type = ?", current_user.id, "Ride"])
    @ridingactivities.sort_by { |a| a.start_date }.reverse
  end
end
