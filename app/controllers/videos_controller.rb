class VideosController < ApplicationController
  respond_to :html, :js, :json

  def new
    video = Video.new
  end

  def create
    @post = Post.find(params[:post_id])
    @video = @post.videos.create(video_params)
    respond_with(@video)
  end
    
  def update
    video = Video.find(params[:id])
    video.update_attributes(video_params)
    respond_with @video
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    respond_with(@video)
  end

  private

  def video_params
    params.require(:video).permit(:title, :note, :link)
  end
end
