class ActivitiesController < ApplicationController
  def index
    # skip_policy_scope
    @activities = policy_scope(Activity)
    # @activities = Activity.all
  end
end
