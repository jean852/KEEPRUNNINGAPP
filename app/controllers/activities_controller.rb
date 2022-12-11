class ActivitiesController < ApplicationController
  def index
    # skip_policy_scope
    @activities = policy_scope(Activity)
    # @activities = Activity.all
    @allactivities = Activity.where(["user_id = ?", current_user.id])

    @runningactivities = Activity.where(["user_id = ? AND activity_type = ?", current_user.id, "Run"])

    @ridingactivities = Activity.where(["user_id = ? AND activity_type = ?", current_user.id, "Ride"])
  end
end
