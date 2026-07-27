class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "Welcome! You've signed up successfully."
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if params[:user][:password].present? && !@user.authenticate(params[:user][:current_password])
      @user.errors.add(:current_password, "is incorrect")
      render :edit
      return
    end
    if @user.update(user_params)
      redirect_to edit_profile_path, notice: "Profile updated successfully."
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :username, :bio, :password, :password_confirmation)
  end

  def require_login
    redirect_to login_path, alert: "Please log in first." unless current_user
  end
end
