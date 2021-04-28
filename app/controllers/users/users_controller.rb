class Users::UsersController < ApplicationController
  before_action :authorize_user

  def authorize_user
    redirect_to admin_camps_path if current_user.admin?
  end
end
