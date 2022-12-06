class User < ActiveRecord::Migration[7.0]
  def change
    add_column(:users, :athlete_id, :integer, null: false, default:'')
  end
end
