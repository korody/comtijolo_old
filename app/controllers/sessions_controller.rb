class SessionsController < ApplicationController
  
  before_action :disable_extras

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      sign_in user
      redirect_back_or root_path
    else
      flash.now[:warning] = "Ops! Pera que deu pêra!"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path, success: "buenas, schatzi : )"
  end
end
