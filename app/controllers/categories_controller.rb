class CategoriesController < ApplicationController
  respond_to :html, :json
  
  before_action :find_category, only: [:show, :edit, :update, :destroy]
  before_action :sidebar_variables, only: :show

  layout 'categories_sidebar', only: :show

  def show
    category_posts = @category.posts
    @posts = category_posts.filter(params).order('posts.created_at DESC').paginate(page: params[:page], per_page: 20)
    # @tags = @category.tags
  end

  def create
    @category = Category.new category_params
  end

  def autocomplete
    @categories = Category.order(:name)
    respond_with(@category) do |format|
      format.json { render json: @categories.tokens(params[:q]) }
    end
  end

  private

  def find_category
    @category = Category.find_by_slug!(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

end
