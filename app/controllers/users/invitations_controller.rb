class Users::InvitationsController < Devise::InvitationsController
  def new
    if current_user.user?
      redirect_to users_path
    elsif current_user.admin?
      super
    end
  end

  def create
    if current_user.user?
      redirect_to users_path
    elsif current_user.admin?
      super
    end
  end
end
