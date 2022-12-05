class CreateSlAccessTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :sl_access_tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :athlete_id
      t.boolean :scope
      t.string :sl_access_token_code
      t.timestamp :expires_at

      t.timestamps
    end
  end
end
