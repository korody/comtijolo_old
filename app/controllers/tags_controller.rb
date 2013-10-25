class TagsController < ApplicationController
  respond_to :html, :json

  def index
    @tags = Tag.order(:name)
    tag_list = @tags.where("name ilike ?", "%#{params[:q]}%").map {|t| {id: t.id, name: t.name} } 
    tag_query = tag_list.empty? ? [{id: "<<<#{params[:q]}>>>", name: "NOVO TEMA: \"#{params[:q]}\""}] : tag_list
    respond_with(@tag) do |format|
      format.json { render json: tag_query }
    end
  end
  #  REVISE for skinny controller

  def show
    @tag = Tag.find_by_name(params[:id])
    @posts = @tag.posts
  end

  def create
    @tag = Tag.new tag_params
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

end
