class UsersController < ApplicationController
  before_action :authorize_user

  def index
  end

  private

  def authorize_user
    redirect_to admin_users_path if current_user.admin?
  end
end
