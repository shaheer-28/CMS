class Admin::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.by_role("user")
  end

  def show 
    @user = User.find(params[:id])
  end
end
