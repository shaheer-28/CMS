class User::CampsRegistrationsController < User::UsersController
  include Wicked::Wizard

  before_action :set_progress, only: [:show]
  before_action :personal_information_params, only: :update
  before_action :check_application_complete

  steps :dashboard, :personal_information, :medical_information, :user_age, :user_dob, :emergency_contact_information, :activities, :is_first_camp, :need_power_bank, :social_media_presence, :suggestions

  def show
    respond_to do |format|
      format.html
      format.js { render :file => "/camps_registrations/show.js.erb" }
    end
    @wizard_steps = wizard_steps
    @user = current_user
    @camps_registration = CampsRegistration.find(session[:camp_reg_id])
    #redirect_to wizard_path(:dashboard) if @camps_registration.application_complete
    @activities_dropdown_list = ["", "Bonfire", "Cards", "Musical night", "Boating"]
    render_wizard
  end

  def update
    @camps_registration = CampsRegistration.find(session[:camp_reg_id])
    case step
    when :personal_information
      gender = params.dig(:camps_registration, :gender)
      user_image = params.dig(:camps_registration, :user_image)
      
      if (gender || user_image) && !@camps_registration.filled_screen1
        @camps_registration.update(filled_screen1: true)
      end
      @camps_registration.update_attributes(gender: gender)
      if @camps_registration.user_image.attached? && user_image
        @camps_registration.user_image.purge_later
        @camps_registration.user_image.attach(user_image)
      end
      
    when :medical_information
      disability_param = params.dig(:camps_registration, :disability)
      medical_services_param = params.dig(:camps_registration, :medical_services)

      if (disability_param || medical_services_param) && !@camps_registration.filled_screen2
        @camps_registration.update(filled_screen2: true)
      end
      @camps_registration.update_attributes(disability: disability_param, medical_services: medical_services_param)

    when :user_age
      user_age = params.dig(:camps_registration, :age)

      if user_age && !@camps_registration.filled_screen3
        @camps_registration.update(filled_screen3: true)
      end
      @camps_registration.update_attributes(age: user_age)

    when :user_dob
      user_dob = params.dig(:camps_registration, :dob)

      if user_dob && !@camps_registration.filled_screen4
        @camps_registration.update(filled_screen4: true)
      end
      @camps_registration.update_attributes(dob: user_dob)

    when :emergency_contact_information
      emergency_contact = params.dig(:camps_registration, :emergency_contact)

      if emergency_contact && !@camps_registration.filled_screen5
        @camps_registration.update(filled_screen5: true)
      end
      @camps_registration.update_attributes(emergency_contact: emergency_contact)

    when :activities
      activity = params.dig(:camps_registration, :activity_of_interest)

      if activity && !@camps_registration.filled_screen6
        @camps_registration.update(filled_screen6: true)
      end
      @camps_registration.update_attributes(activity_of_interest: activity)

    when :is_first_camp
      first_camp = params.dig(:camps_registration, :is_first_camp)

      if first_camp && !@camps_registration.filled_screen7
        @camps_registration.update(filled_screen7: true)
      end
      @camps_registration.update_attributes(is_first_camp: first_camp)

    when :need_power_bank
      require_power_bank = params.dig(:camps_registration, :need_power_bank)

      if require_power_bank && !@camps_registration.filled_screen8
        @camps_registration.update(filled_screen8: true)
      end
      @camps_registration.update_attributes(need_power_bank: require_power_bank)

    when :social_media_presence
      social_media_presence = params.dig(:camps_registration, :social_media_presence)

      if social_media_presence && !@camps_registration.filled_screen9
        @camps_registration.update(filled_screen9: true)
      end
      @camps_registration.update_attributes(social_media_presence: social_media_presence)

    when :suggestions
      suggestion = params.dig(:camps_registration, :suggestion)

      if suggestion || !@camps_registration.filled_screen10
        @camps_registration.update(filled_screen10: true)
        byebug
      end
      @camps_registration.update_attributes(suggestion: suggestion)

      if @camps_registration.application_completed == 100
        @camps_registration.update(application_complete: true)
        redirect_to (wizard_path(:dashboard)) and return
      else
        flash[:notice] = "Complete all steps of application and then submit"
        redirect_to (wizard_path(:dashboard)) and return
      end
      
    end
    render_wizard(@camps_registration) 
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
    @camps_registration = CampsRegistration.find(session[:camp_reg_id])
    if @camps_registration.application_complete && wizard_steps.index(step) != 0
      redirect_to wizard_path(:dashboard), notice: "Cannot access Application after submitting"
    end
  end
end
