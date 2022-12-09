class AddColumnToChallenges < ActiveRecord::Migration[7.0]
  def change
    add_column :challenges, :bet_amount, :integer
  end
end
