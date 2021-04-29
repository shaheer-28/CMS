class User::CampsRegistrationsController < User::UsersController
  include Wicked::Wizard

  before_action :personal_information_params, only: :update

  steps :personal_information, :medical_information, :user_age, :user_dob, :emergency_contact_information, :activities, :is_first_camp, :need_power_bank, :social_media_presence, :suggestions

  def show
    @user = current_user
    @camps_registration = CampsRegistration.find(session[:camp_reg_id])
    case step
    when :personal_information
    when :medical_information
    end
    render_wizard
  end

  def update
    @camps_registration = CampsRegistration.find(session[:camp_reg_id])
    case step
    when :personal_information
      
    when :medical_information
      @camps_registration.update_attributes(disability: params.dig(:camps_registration, :disability), medical_services: params.dig(:camps_registration, :medical_services))
    when :user_age

    end
    render_wizard(@camps_registration) 
  end
  
  def finish_wizard_path
    user_camps_path
  end

  private
  
  def personal_information_params
    params.require(:camps_registration).permit(:disability, :medical_services)
  end
end
