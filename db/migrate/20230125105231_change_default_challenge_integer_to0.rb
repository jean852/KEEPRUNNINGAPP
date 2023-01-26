class ChangeDefaultChallengeIntegerTo0 < ActiveRecord::Migration[7.0]
  def change
    change_column_default :challenges, :target_distance, 0
    change_column_default :challenges, :target_sessions, 0
  end
end
