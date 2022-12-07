class ChangeColumnNameOnChallenges < ActiveRecord::Migration[7.0]
  def change
    rename_column :challenges, :type, :challenge_type
  end
end
