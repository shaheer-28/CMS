class Overridden::InvitationsController < Devise::InvitationsController
  before_action :validate_admin, only: %i[create new]

  def new
    super if current_user.admin?
  end

  def create
    super if current_user.admin?
  end

  private 

  def validate_admin
    if current_user.user?
      redirect_to users_path
    end
  end
end
