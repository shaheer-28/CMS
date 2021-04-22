class Admin::AdminsController < ApplicationController
  before_action :authorize_admin

  def authorize_admin
    redirect_to users_path if current_user.user?
  end
end
