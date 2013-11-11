class VideosController < ApplicationController
  respond_to :html, :js, :json

  def create
    @video = Video.create(video_params) 
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
    params.require(:video).permit(:title, :note, :link, :filmable_type)
  end
end
