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
    tag_list = @tags.where("name ilike ?", "%#{params[:q]}%").map {|t| {id: t.id, name: t.name} } 
    tag_query = tag_list.empty? ? [{id: "<<<#{params[:q]}>>>", name: "nova tag: \"#{params[:q]}\""}] : tag_list
    respond_with(@tag) do |format|
      format.json { render json: tag_query }
    end
  end
  #  REVISE for skinny controller

  private

  def find_tag
    @tag = Tag.find_by_slug!(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end

end
