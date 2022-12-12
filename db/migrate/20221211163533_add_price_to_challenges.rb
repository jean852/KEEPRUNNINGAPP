class AddPriceToChallenges < ActiveRecord::Migration[7.0]
  def change
    add_monetize :challenges, :price, currency: { present: false }
  end
end
