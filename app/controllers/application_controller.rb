# encoding: UTF-8
class ApplicationController < ActionController::Base
  include SessionsHelper

  protect_from_forgery with: :exception
  add_flash_types :error, :success, :info, :warning

  private

  def new_message
    @message = Message.new
  end

  def require_login
    unless signed_in?
      store_location
      redirect_to signin_path, warning: "Ei schatz, é você? Faltou o login."
    end
  end
end
