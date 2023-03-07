class UsersController < ApplicationController
  include Pundit
  before_action :authorize_user, only: %i[show edit update destroy]
  before_action :set_user, only: %i[edit update]

  def index
    @users = policy_scope(User)
  end

  def show
    set_user
    authorize_user
  end

  def edit
    set_user
    authorize_user
  end

  def update
    set_user
    authorize_user
    if @user.update(user_params)
      flash[:notice] = "Your email address has been successfully updated."
      # Send email to user
      UserMailer.welcome_email(@user).deliver_now
      redirect_to user_root_path
    else
      flash[:notice] = "There was an error updating your email address: #{@user.errors.full_messages.join(', ')}"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

  def authorize_user
    authorize @user
  end

  def set_user
    @user = current_user
  end
end
