class AddTargetSessionsToChallenges < ActiveRecord::Migration[7.0]
  def change
    add_column :challenges, :target_sessions, :integer
  end
end
