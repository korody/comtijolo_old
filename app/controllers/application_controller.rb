class ApplicationController < ActionController::Base
  include SessionsHelper
  include HTTParty

  protect_from_forgery with: :exception
  add_flash_types :success, :info, :warning, :danger

  private

  def sidebar_variables
    @collections = Collection.select(:name, :slug)
    @recommended = Post.where(recommended: true)
    @posts_by_month = Post.select(:name, :slug, :html, :id, :created_at).group_by { |post| post.created_at.beginning_of_month }
    @instagram = Instagram.user_recent_media(access_token: ENV['INSTA_ACCESS_TOKEN'], count: 4)
    @message = Message.new
  end

  def disable_extras
    @disable_header = true
    @disable_sidebar = true
  end

  def require_login
    unless signed_in?
      store_location
      redirect_to signin_path, warning: "Ei schatz, é você? Faltou o login."
    end
  end
end