class Admin::UsersController < ApplicationController
  before_action :check_role
  before_action :get_user, only: [:show, :edit, :update]
  before_action :user_params, only: :update

  def index
    @users = User.by_role(User.roles[:user])
  end

  def show 
  end

  def edit
  end

  def update
    @user.attributes = user_params
    if @user.save(context: :update)
      redirect_to admin_users_path
    end
    #redirect_to admin_users_path if @user.update(first_name: params[:first_name], middle_name: params[:middle_name], last_name: params[:last_name], country: params[:country], phone_number: params[:phone_number] )
  end

  private

  def check_role
    redirect_to users_path if current_user.user?
  end

  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :middle_name, :last_name, :country, :phone_number, :email)
  end
end
