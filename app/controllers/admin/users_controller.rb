class Admin::UsersController < ApplicationController
  def index
    @users = User.by_role(User.roles[:user])
  end

  def show 
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id]).destroy
    redirect_to admin_users_path
  end
end
