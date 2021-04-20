class UsersController < ApplicationController
  before_action :check_role

  def index
  end

  private

  def check_role
    redirect_to admin_users_path if current_user.admin?
  end
end
