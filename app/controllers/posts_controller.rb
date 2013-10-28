class PostsController < ApplicationController
  before_action :require_login, except: [:show, :index] 

  def index
    @posts = Post.all(limit: 10)
  end

  def new
    @post = current_user.posts.build
    @post.attachments.build
  end

  def edit
    @post = Post.find(params[:id])
    @video = Video.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, success: "Post atualizado com sucesso."
    else
      render 'edit'
    end
  end

  # def destroy
  #   current_user.posts.find(params[:id]).destroy
  #   flash[:notice] = "Post removido."
  #   redirect_to current_user
  # end

  private

  def post_params
    params.require(:post).permit(:name, :content, :user, :category_tokens, :tag_tokens, videos_attributes: [:title, :note, :link])
  end

end
