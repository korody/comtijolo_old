class CollectionsController < ApplicationController
  respond_to :html, :json

  before_action :find_collection, only: [:show, :edit, :update, :destroy]
  before_action :disable_extras, only: [:new, :create, :update, :edit]
  before_action :sidebar_variables, only: :show

  layout 'posts_sidebar', only: :show

  def show
    @posts = @collection.posts
  end

  def create
    @collection = Collection.new collection_params
  end

  def update
    if @collection.update(collection_params)
      redirect_to @collection, success: "Série atualizada com sucesso."
    else
      render 'edit'
    end
  end

  def autocomplete
    @collections = Collection.order(:name)
    respond_with(@collection) do |format|
      format.json { render json: @collections.tokens(params[:q]) }
    end
  end

private

  def find_collection
    @collection = Collection.find_by_slug!(params[:id])
  end

  def collection_params
    params.require(:collection).permit(:name, :description)
  end
end