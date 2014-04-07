class PostsController < ApplicationController
  respond_to :html, :js, :json

  before_action :require_login, except: [:show, :index] 
  before_action :find_post, only: [:show, :edit, :update, :destroy, :recommend, :unrecommend]
  before_action :disable_extras, only: [:new, :create, :update, :edit]
  before_action :sidebar_variables, only: [:show, :index]

  layout 'posts_sidebar', only: [:index, :show]

  def index
    @posts = Post.filter(params).order('posts.created_at DESC')#.paginate(page: params[:page], per_page: 20)
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
    post_list = @posts.where("name ilike ?", "%#{params[:q]}%").map {|p| {id: p.id, name: p.name} } 
    post_query = post_list.empty? ? [{id: "<<<#{params[:q]}>>>", name: "novo post: \"#{params[:q]}\""}] : post_list
    respond_with(@post) do |format|
      format.json { render json: post_query }
    end
  end
  #  REVISE for skinny controller

  private

  def find_post
    @post = Post.find_by_slug!(params[:id].split("/").last)
  end

  def disable_extras
    @disable_header = true
    @disable_sidebar = true
  end

  def post_params
    params.require(:post).permit(:name, :content, :description, :user, :category_tokens, :tag_tokens, :complements_tokens, :attachment_ids, :video_ids, attachments_attributes: [:file, :note, :attachable], videos_attributes: [:title, :note, :link, :filmable])
  end

end
