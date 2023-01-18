class AddNameToChallenges < ActiveRecord::Migration[7.0]
  def change
    add_column :challenges, :name, :string
  end
end
