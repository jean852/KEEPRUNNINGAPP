class UsersController < ApplicationController
  include Pundit
  before_action :authorize_user, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:edit, :update]

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
      flash[:success] = "Your email address has been successfully updated."
      redirect_to user_root_path
    else
      flash[:error] = "There was an error updating your email address: #{@user.errors.full_messages.join(', ')}"
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
