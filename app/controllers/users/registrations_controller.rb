class Users::RegistrationsController < Devise::RegistrationsController
    # Override the action you want here.
  before_action :configure_permitted_parameters

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :middle_name, :last_name, :country, :phone_number])
  end
end
