class Api::V1::CampsRegistrationsController < Api::BaseController
  def index
    camps_registrations = CampsRegistration.all
    return render_success({camps_registrations: camps_registrations}) 
  end

  def show
    camps_registration = CampsRegistration.find_by(params[:id])
    return render_failure("Could not find record with the sent id")
  end
end
