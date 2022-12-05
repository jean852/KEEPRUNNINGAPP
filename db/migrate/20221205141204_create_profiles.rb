class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :country
      t.string :username
      t.string :sex
      t.string :profile_url

      t.timestamps
    end
  end
end
