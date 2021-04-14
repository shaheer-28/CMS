class Admin::UsersController < ApplicationController
  def index
    @users = User.by_role(User.roles[:user])
  end

  def show 
    @user = User.find(params[:id])
  end
end
