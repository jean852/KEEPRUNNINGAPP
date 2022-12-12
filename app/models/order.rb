class Order < ApplicationRecord
  belongs_to :user
  belongs_to :challenge

  monetize :amount_cents
end
