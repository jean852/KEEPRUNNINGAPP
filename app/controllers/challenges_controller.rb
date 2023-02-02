class ChallengesController < ApplicationController
  before_action :set_challenge, only: %i[show edit update destroy]

  def index
    @challenges = policy_scope(Challenge)
    # @challenges = Challenge.all
  end

  def new
    @challenge = Challenge.new
    authorize @challenge
  end

  def show
    authorize @challenge
  end

  def create
    @challenge = Challenge.new(challenge_params)
    @challenge.user = current_user
    @challenge.status = "PENDING"

    if @challenge.save
      if @challenge.price_cents.zero?
        # USER DIDNT SELECT ANY AMOUNT WE REDICT TO CHALLENGE DETAIL PAGE
        redirect_to challenge_path(@challenge)
      else
        # USER SELECTED AN AMOUNT WE GONNA CREATE THE STRIPE ORDER AND PAYMENT
        @order = Order.create!(challenge: @challenge, amount: @challenge.price_cents, state: 'pending', user: current_user)

        # Aurélie: Send email to user
        UserMailer.new_challenge_created(@challenge).deliver_now

        session = Stripe::Checkout::Session.create(
          payment_method_types: ['card'],

          line_items: [{
            price_data: {
              currency: 'eur',
              product_data: {
                name: "Challenge #{@challenge.id}"
              },
              unit_amount: @challenge.price_cents
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
    else
      render :new # TODO: redirect to correct step
    end
    authorize @challenge
  end



  def edit
    authorize @challenge
  end



  # TODO: maybe switch this method to only update status
  def update
    @challenge.update(challenge_params)

    if @challenge.save
      redirect_to challenge_path(@challenge)
    else
      render :edit
    end
    authorize @challenge
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  def challenge_params
    params.require(:challenge).permit(:activity_type, :challenge_type, :start_date, :end_date, :target_distance, :price, :name, :target_sessions)
  end
end
