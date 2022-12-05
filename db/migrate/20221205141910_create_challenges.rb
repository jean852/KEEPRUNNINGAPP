class CreateChallenges < ActiveRecord::Migration[7.0]
  def change
    create_table :challenges do |t|
      t.references :user, null: false, foreign_key: true
      t.string :activity_type
      t.string :type
      t.date :start_date
      t.date :end_date
      t.integer :target_distance
      t.string :status

      t.timestamps
    end
  end
end
