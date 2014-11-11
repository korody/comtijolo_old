class SearchesController < ApplicationController
  before_action :sidebar_variables, only: :new

  layout 'searches_sidebar', only: :new

  def new
    @posts_query = Post.search(params[:query])
    @collections_query = Collection.search(params[:query])
    @tags_query = Tag.search(params[:query])
  end
end