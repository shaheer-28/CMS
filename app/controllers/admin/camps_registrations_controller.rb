class Admin::CampsRegistrationsController < Admin::AdminsController
  def index
    @camps_registrations = CampsRegistration.all
  end

  def show
    @camps_registration = CampsRegistration.find(params[:id])
  end
end
