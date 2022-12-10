class ChangeIntegerLimitInYourActivities < ActiveRecord::Migration[7.0]
  def change
    change_column :activities, :strava_id, :integer, limit: 8
  end
end
