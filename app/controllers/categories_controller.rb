class CategoriesController < ApplicationController
  respond_to :html, :json

  def index
    @categories = Category.order(:name)
    category_list = @categories.where("name ilike ?", "%#{params[:q]}%").map {|e| {id: e.id, name: e.name} } 
    category_query = category_list.empty? ? [{id: "<<<#{params[:q]}>>>", name: "novo item: \"#{params[:q]}\""}] : category_list
    respond_with(@category) do |format|
      format.json { render json: category_query }
    end
  end
  #  REVISE for skinny controller

  def show
    @category = Category.find_by_name(params[:id])
    @posts = @category.posts
  end

  def create
    @category = Category.new category_params
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
