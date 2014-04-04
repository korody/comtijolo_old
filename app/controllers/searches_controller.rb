class SearchesController < ApplicationController
  before_action :new_message, only: :new

  layout 'searches_sidebar', only: :new

  def new
    @posts = Post.search(params[:query])
    @tags = Tag.search(params[:query])
  end
end