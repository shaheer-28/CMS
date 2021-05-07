class User::CampsRegistrationsController < User::UsersController
  include Wicked::Wizard
  include Registerable

  before_action :set_progress, only: [:show]
  before_action :personal_information_params, only: :update
  before_action :set_camps_registration
  before_action :check_application_complete


  steps :dashboard, :personal_information, :medical_information, :user_age, :user_dob, :emergency_contact_information, :activities, :is_first_camp, :need_power_bank, :social_media_presence, :suggestions

  def show
    @wizard_steps = wizard_steps
    @activities_dropdown_list = CampsRegistration::ACTIVITIES
    render_wizard
  end

  def update
    redirect_to (wizard_path(:dashboard)) if @camps_registration.application_completed == 100

    render_wizard update_application_steps
  end

  private
  
  def personal_information_params
    params.require(:camps_registration).permit(:user_image, :gender, :medical_services)
  end

  def set_progress
    if wizard_steps.any? && wizard_steps.index(step).present?
      @progress = ((wizard_steps.index(step) + 1).to_d / wizard_steps.count.to_d) * 100
    else
      @progress = 0
    end
  end

  def check_application_complete
    if @camps_registration.application_complete && wizard_steps.index(step) != 0
      redirect_to wizard_path(:dashboard), notice: "Cannot access Application after submitting"
    end
  end

  def set_camps_registration
    @camps_registration = CampsRegistration.find(session[:camp_reg_id])
  end
end
