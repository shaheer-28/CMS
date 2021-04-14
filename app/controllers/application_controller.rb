class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  
  def after_sign_in_path_for(resource)
    if current_user.admin?
      stored_location_for(resource) || admin_users_path
    elsif current_user.user?
      stored_location_for(resource) || users_path
    end
  end
end
