class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.integer :strava_id
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :distance
      t.integer :moving_time
      t.integer :elapsed_time
      t.string :activity_type
      t.date :start_date
      t.float :average_speed

      t.timestamps
    end
  end
end
