class SearchesController < ApplicationController
  before_action :new_message, only: :new
  before_action :recommend_post, only: :new

  layout 'searches_sidebar', only: :new

  def new
    @posts = Post.search(params[:query])
    @tags = Tag.search(params[:query])
  end
end