class OrdersController < ApplicationController


  def create
    challenge = Challenge.find(params[:challenge_id])
    @order = Order.create!(challenge: challenge, amount: challenge.price_cents, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],

      line_items: [{
        price_data: {
          currency: 'eur',
          product_data: {
            name: "Challenge #{challenge.id}"
          },
          unit_amount: challenge.price_cents
        },
        quantity: 1
        }],
        mode: 'payment',
        success_url: order_url(@order),
        cancel_url: order_url(@order)
      )

    authorize @order
    @order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(@order)
  end

  def show
    @order = current_user.orders.find(params[:id])
    authorize @order
  end

end
