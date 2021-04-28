class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  
  def after_sign_in_path_for(resource)
    if current_user.admin?
      stored_location_for(resource) || admin_camps_path
    elsif current_user.user?
      stored_location_for(resource) || users_camps_path
    end
  end

  protected

  # => Method used by devse_inviter to confirm that only valid users can send invitations.
  def authenticate_inviter!
    authenticate_user!(force: true)
  end
end
