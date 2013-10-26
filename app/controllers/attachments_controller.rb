class AttachmentsController < ApplicationController
  respond_to :html, :js, :json

  def create
    @post = Post.find(params[:post_id])
    @attachment = @post.attachments.build(attachment_params)
    @attachment.save!
  end
    
  def update
    @attachment = Attachment.find(params[:id])
    @attachment.update_attributes(attachment_params)
    respond_with @attachment
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
    respond_with(@attachment)
  end

  private

  def attachment_params
    params.require(:attachment).permit(:note, :file)
  end

end
