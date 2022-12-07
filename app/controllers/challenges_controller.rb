class ChallengesController < ApplicationController
  before_action :set_challenge, only: %i[show edit update destroy]

  def index
    @challenges = Challenge.all
  end

  def new
    @challenge = Challenge.new
  end

  def create
    @challenge = Challenge.new(challenge_params)
    @challenge.user = current_user

    if @challenge.save
      redirect_to challenge_path(@challenge) # TODO: redirect to payment
    else
      render :new # TODO: redirect to correct step
    end
  end

  def show
  end

  def edit
  end

  # TODO: maybe switch this method to only update status
  def update
    @challenge.update(challenge_params)

    if @challenge.save
      redirect_to challenge_path(@challenge)
    else
      render :edit
    end
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  def challenge_params
    params.require(:challenge).permit(:activity_type, :challenge_type, :start_date, :end_date, :target_distance, :status)
  end
end
