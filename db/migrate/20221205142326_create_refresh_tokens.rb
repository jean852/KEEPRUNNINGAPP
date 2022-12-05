class CreateRefreshTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :refresh_tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :athlete_id
      t.string :refresh_token_code
      t.boolean :scope

      t.timestamps
    end
  end
end
