class PostsController < ApplicationController
  respond_to :html, :js, :json

  before_action :require_login, except: [:show, :index] 
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :disable_extras, only: [:new, :create, :update, :edit]

  layout 'posts_sidebar', only: :index

  def index
    @message = Message.new
    @posts = Post.filter(params).order('posts.created_at DESC').paginate(page: params[:page], per_page: 20)
    @posts_by_month = @posts.group_by { |post| post.created_at.beginning_of_month }
    @tags = Tag.all
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @user = current_user
    @post = @user.posts.build(post_params)
    attachments = Attachment.all
    post_attachments = attachments.where(id: @post.attachment_ids.split(','))
    @post.attachments << post_attachments
    videos = Video.all
    post_videos = videos.where(id: @post.video_ids.split(','))
    @post.videos << post_videos
    if @post.save
      redirect_to @post, success: "Que post irado que foi criado! : P"
    else
      render :new
    end
  end

  def edit
  end

  def show
    @posts_by_month = Post.all.group_by { |post| post.created_at.beginning_of_month }
    @tags = Tag.all
  end

  def update
    @post.attributes = post_params
    attachments = Attachment.all
    post_attachments = attachments.where(id: @post.attachment_ids.split(','))
    @post.attachments << post_attachments
    videos = Video.all
    post_videos = videos.where(id: @post.video_ids.split(','))
    @post.videos << post_videos
    if @post.update(post_params)
      redirect_to @post, success: "Post atualizado com sucesso."
    else
      render 'edit'
    end
  end

  def destroy
    @post = current_user.posts.find_by_slug!(params[:id]).destroy
    # @post.destroy
    flash[:notice] = "Post removido."
    redirect_to current_user
  end

  private

  def find_post
    @post = Post.find_by_slug!(params[:id].split("/").last)
  end

  def post_params
    params.require(:post).permit(:name, :content, :user, :category_tokens, :tag_tokens, :attachment_ids, :video_ids, attachments_attributes: [:file, :note, :attachable], videos_attributes: [:title, :note, :link, :filmable])
  end

end
