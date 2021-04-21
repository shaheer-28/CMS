class Admin::UsersController < ApplicationController
  before_action :get_user, only: %i[show update destroy]

  def index
    @users = User.by_role(User.roles[:user])
  end

  def show
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def get_user
    @user = User.find(params[:id])
  end
end
