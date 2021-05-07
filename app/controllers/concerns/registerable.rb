module Registerable
  extend ActiveSupport::Concern

  included do
    def update_application_steps
      case step
      when :personal_information
        registration_params = { gender: params.dig(:camps_registration, :gender) }
        screen_status = { filled_screen1: true }
        update_screen_conditions = (params.dig(:camps_registration, :gender) || params.dig(:camps_registration, :user_image)) && !@camps_registration.filled_screen1

        user_image = params.dig(:camps_registration, :user_image)
        @camps_registration.user_image.purge_later if @camps_registration.user_image.attached? && user_image
        @camps_registration.user_image.attach(user_image) if @camps_registration.user_image.attached? && user_image
        
      when :medical_information
        registration_params = { disability: params.dig(:camps_registration, :disability) }
        screen_status = { filled_screen2: true }
        update_screen_conditions = (params.dig(:camps_registration, :disability) || params.dig(:camps_registration, :medical_services)) && !@camps_registration.filled_screen2

      when :user_age
        registration_params = { age: params.dig(:camps_registration, :age) }
        screen_status = { filled_screen3: true }
        update_screen_conditions = params.dig(:camps_registration, :age) && !@camps_registration.filled_screen3

      when :user_dob
        registration_params = { dob: params.dig(:camps_registration, :dob) }
        screen_status = { filled_screen4: true }
        update_screen_conditions = params.dig(:camps_registration, :dob) && !@camps_registration.filled_screen4

      when :emergency_contact_information
        registration_params = { emergency_contact: params.dig(:camps_registration, :emergency_contact) }
        screen_status = { filled_screen5: true }
        update_screen_conditions = params.dig(:camps_registration, :emergency_contact) && !@camps_registration.filled_screen5

      when :activities
        registration_params = { activity_of_interest: params.dig(:camps_registration, :activity_of_interest) }
        screen_status = { filled_screen6: true }
        update_screen_conditions = params.dig(:camps_registration, :activity_of_interest) && !@camps_registration.filled_screen6

      when :is_first_camp
        registration_params = { is_first_camp: params.dig(:camps_registration, :is_first_camp) }
        screen_status = { filled_screen7: true }
        update_screen_conditions = params.dig(:camps_registration, :is_first_camp) && !@camps_registration.filled_screen7

      when :need_power_bank
        registration_params = { need_power_bank: params.dig(:camps_registration, :need_power_bank) }
        screen_status = { filled_screen8: true }
        update_screen_conditions = params.dig(:camps_registration, :need_power_bank) && !@camps_registration.filled_screen8

      when :social_media_presence
        registration_params = { social_media_presence: params.dig(:camps_registration, :social_media_presence) }
        screen_status = { filled_screen9: true }
        update_screen_conditions = params.dig(:camps_registration, :social_media_presence) && !@camps_registration.filled_screen9

      when :suggestions
        update_screen_conditions = !@camps_registration.filled_screen10
          
        if @camps_registration.application_completed == CampsRegistration::PROGRESS_90 
          registration_params = { application_complete: true }
          screen_status = { filled_screen10: true }
        else 
          jump_to(:suggestions)
          flash[:notice] =  'Complete all steps of application and then submit.'
        end
      end

      @camps_registration.update_attributes(registration_params) if registration_params
      @camps_registration.update(screen_status) if update_screen_conditions if screen_status

      @camps_registration
    end
  end
end
