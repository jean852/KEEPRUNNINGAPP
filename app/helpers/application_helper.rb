module ApplicationHelper

  def price_in_euros(price_cents)
    (price_cents / 100.0).round(2)
  end

end
