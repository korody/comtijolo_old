class AttachmentsController < ApplicationController
  respond_to :html, :js, :json

  def create
    @attachment = Attachment.create(attachment_params)
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
    params.require(:attachment).permit(:note, :file, :attachable_type)
  end

end
