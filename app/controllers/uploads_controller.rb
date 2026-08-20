class UploadsController < ApplicationController
  before_action :require_login

  def create
    S3Uploader.new(file: params[:file], attachable: current_user).call
    redirect_to edit_profile_path, notice: "Picture uploaded successfully."
  end

  private def require_login
    redirect_to login_path, alert: "Please login first." unless current_user
  end
end