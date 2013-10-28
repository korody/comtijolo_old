# encoding: UTF-8
class UsersController < ApplicationController
  before_action :require_login, :set_user, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to root_path, success: "Usuário criado com sucesso! : )"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def properties    
  end

  def favourites
  end

  def comparatives
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, success: "Perfil atualizado com sucesso."
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :password)
  end

  def set_user
    @user ||= User.find(current_user)
  end
end
