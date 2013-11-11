 # encoding: UTF-8
class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :delete]
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @tags = Tag.all
  end

  def new
    @disable_header = true
    @disable_sidebar = true
    @user = User.new
  end

  def create
    @disable_header = true
    @disable_sidebar = true
    @user = User.new(user_params)
    attachments = Attachment.all
    user_attachments = attachments.where(id: @user.attachment_ids.split(','))
    @user.attachments << user_attachments
    videos = Video.all
    user_videos = videos.where(id: @user.video_ids.split(','))
    @user.videos << user_videos
    if @user.save
      sign_in @user
      redirect_to root_path, success: "Usuário criado com sucesso! : )"
    else
      render :new
    end
  end

  def show
    @tags = Tag.all
    @posts = @user.posts.all
  end

  def edit
    @disable_header = true
    @disable_sidebar = true
  end

  def update
    @disable_header = true
    @disable_sidebar = true
    @user.attributes = user_params
    attachments = Attachment.all
    user_attachments = attachments.where(id: @user.attachment_ids.split(','))
    @user.attachments << user_attachments
    videos = Video.all
    user_videos = videos.where(id: @user.video_ids.split(','))
    @user.videos << user_videos
    if @user.update(user_params)
      redirect_to @user, success: "Usuário atualizado com sucesso."
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :bio, :email, :phone, :password, :attachment_ids, :video_ids, attachments_attributes: [:file, :note, :attachable], videos_attributes: [:title, :note, :link, :filmable])
  end

  def find_user
    @user = User.find_by_slug!(params[:id].split("/").last)
  end
end
