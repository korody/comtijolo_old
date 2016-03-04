class PasswordResetsController < ApplicationController
  before_action :disable_extras

  def new
  end

  def create
    password_reset = PasswordReset.from_email(params[:email])
    if password_reset.user
      password_reset.send_email
      redirect_to signin_path, info: "We sent you an email with password reset instructions."
    else
      redirect_to new_password_reset_path, error: "Email address does not match a user account."
    end
  end

  def edit
    password_reset = PasswordReset.from_token(params[:id])
    @user = password_reset.user
  end

  def update
    password_reset = PasswordReset.from_token(params[:id])
    @user = password_reset.user
    if password_reset.expired?
      redirect_to new_password_reset_path, warning: "Password reset token has expired. Please request a new one."
    elsif @user.update(user_params)
      redirect_to root_path, success: "Password updated successfully."
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password)
  end
end
