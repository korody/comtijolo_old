# encoding:   utf-8
class ContactController < ApplicationController
  before_action :recommend_post, only: [:index, :new] 
  before_action :new_message, only: [:index, :new]

  def index
    @tags = Tag.all
  end

  def new
  end

  def create
    @message = Message.new(message_params)
    if @message.valid?
      UserMailer.contact(@message).deliver
      # flash[:sent] = "Obrigado #{@message.name}! Kalina e eu responderemos sua mensagem em breve : )".html_safe
    else
      respond_to do |format|
        format.html {  }
        format.js 
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :subject, :text)
  end

end
