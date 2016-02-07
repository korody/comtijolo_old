class PostsController < ApplicationController
  respond_to :html, :js, :json

  before_action :require_login, except: [:show, :index, :archive, :feed] 
  before_action :find_post, only: [:show, :edit, :update, :destroy, :recommend, :unrecommend]
  before_action :disable_extras, only: [:new, :create, :update, :edit]
  before_action :sidebar_variables, only: [:show, :index, :archive]

  layout 'posts_sidebar', only: [:index, :show, :archive]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 3)
    @recent_posts = Post.select(:name, :slug, :html, :id).first(6)
  end

  def archive
  end

  def feed
    @posts = Post.all
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
    @complements = @post.complements.all
    @collections = @post.collections.all
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
    @post.destroy
    flash[:notice] = "Post removido."
    redirect_to root_path
  end

  def unrecommend
    @post.update(recommended: false)
    redirect_to :back
  end

  def recommend
    @post.update(recommended: true)
    redirect_to :back
  end

  def autocomplete
    @posts = Post.order(:name)
    respond_with(@post) do |format|
      format.json { render json: @posts.tokens(params[:q]) }
    end
  end

  private

  def find_post
    @post = Post.find_by_slug!(params[:id].split("/").last)
  end

  def post_params
    params.require(:post).permit(:name, :content, :html, :description, :user, :recommended, :category_tokens, :collection_tokens, :tag_tokens, :complements_tokens, :attachment_ids, :video_ids, attachments_attributes: [:file, :note, :attachable], videos_attributes: [:title, :note, :link, :filmable])
  end
end