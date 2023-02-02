module ApplicationHelper

  def price_in_euros(price_cents)
    price_cents / 100.00
  end

end
