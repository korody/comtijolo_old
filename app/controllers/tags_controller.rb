class TagsController < ApplicationController
  respond_to :html, :json

  before_action :find_tag, only: [:show, :edit, :update, :destroy]
  before_action :sidebar_variables, only: :show

  layout 'posts_sidebar', only: :show



  def show
    @posts = @tag.posts
  end

  def create
    @tag = Tag.new tag_params
  end

  def autocomplete
    @tags = Tag.order(:name)
    respond_with(@tag) do |format|
      format.json { render json: @tags.tokens(params[:q]) }
    end
  end

  private

  def find_tag
    @tag = Tag.find_by_slug!(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end

end
