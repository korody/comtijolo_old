# encoding: UTF-8
class ApplicationController < ActionController::Base
  include SessionsHelper
  # include HTTParty

  protect_from_forgery with: :exception
  add_flash_types :error, :success, :info, :warning

  private

  def sidebar_variables
    @recommended = Post.where(recommended: true)
    @posts_by_month = Post.select(:name, :slug, :html, :id, :created_at).group_by { |post| post.created_at.beginning_of_month }
    @collections = Collection.all.order('collections.created_at DESC')
    @message = Message.new
    @instagram = Instagram.user_recent_media(access_token: ENV['INSTA_ACCESS_TOKEN'], count: 4)
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