class ContactController < ApplicationController
  before_action :sidebar_variables, only: [:index, :new]

  layout 'users_sidebar', only: :index

  def index
    @categories = Category.select(:name, :slug, :id)
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