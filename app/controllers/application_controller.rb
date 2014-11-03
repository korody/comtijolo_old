# encoding: UTF-8
class ApplicationController < ActionController::Base
  include SessionsHelper
  include HTTParty

  protect_from_forgery with: :exception
  add_flash_types :error, :success, :info, :warning

  private

  def sidebar_variables
    @recommended = Post.where(recommended: true)
    @posts_by_month = Post.all(select: "name, slug, content, id, created_at").group_by { |post| post.created_at.beginning_of_month }
    @tags = Tag.all.order('tags.created_at DESC')
    @message = Message.new
    @instagram = Instagram.user_recent_media(access_token: ENV['INSTA_ACCESS_TOKEN'], count: 4)
  end

  def require_login
    unless signed_in?
      store_location
      redirect_to signin_path, warning: "Ei schatz, é você? Faltou o login."
    end
  end
end