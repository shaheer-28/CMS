class Admin::CampsRegistrationsController < Admin::AdminsController
  before_action :set_camps_registration, only: %i[show destroy]
  def index
    @camps_registrations = CampsRegistration.all
  end

  def show; end

  def destroy
    if @camps_registration.destroy
      redirect_to admin_camps_registrations_path, notice: "Camp registration destroyed"
    else
      redirect_to admin_camps_registrations_path, notice: "Could not destroy camp camp registration"
    end

  end

  private

  def set_camps_registration
    @camps_registration = CampsRegistration.find(params[:id])
  end
end
