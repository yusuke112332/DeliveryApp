class UsersController < ApplicationController

  def index
    @users = User.all.order('created_at DESC').page(params[:page]).per(9)
  end

  def show
    @user = User.find_by(id: params[:id])
  end

end
