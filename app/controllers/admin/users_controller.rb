class Admin::UsersController < Admin::AdminsController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.by_role(User.roles[:user])
  end

  def show; end

  def edit; end

  def update
    @user.avatar.purge_later if @user.avatar.attached? && params[:avatar]
    @user.skip_password_validations = true

    if @user.update_without_password(user_params)
      redirect_to admin_users_path, notice: 'User Updated'
    else
      render 'edit'
    end
  end
  
  def destroy
    @user.destroy
    redirect_to admin_users_path
  end
  
  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :middle_name, :last_name, :country, :phone_number, :email, :avatar)
  end
end
