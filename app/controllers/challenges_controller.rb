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
        redirect_to challenge_path(@challenge)
      else
        redirect_to orders_path(challenge_id: @challenge.id)
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
    params.require(:challenge).permit(:activity_type, :challenge_type, :start_date, :end_date, :target_distance, :price_cents)
  end
end
