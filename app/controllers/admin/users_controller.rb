class Admin::UsersController < ApplicationController
  before_action :check_role
  before_action :get_user, only: [:show, :edit, :update]
  before_action :user_params, only: :update

  def index
    @users = User.by_role(User.roles[:user])
  end

  def show; end

  def edit; end

  def update
    @user.avatar.purge_later if @user.avatar.attached? && params[:avatar]
    @user.attributes = user_params
    if @user.save(validate: false)
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  private

  def check_role
    redirect_to users_path if current_user.user?
  end

  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :middle_name, :last_name, :country, :phone_number, :email, :avatar)
  end
end
