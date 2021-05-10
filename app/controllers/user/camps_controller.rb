class User::CampsController < User::UsersController
  before_action :set_camp, only: %i[show introduction]
  
  def index
    session[:camp_reg_id] = nil
    @camps = Camp.all
  end

  def introduction
    @allow_to_proceed = @camp.allow_to_proceed?
    if @allow_to_proceed
      @camp_reg = CampsRegistration.find_by(user_id: current_user.id, camp_id: params[:id])

      if @camp_reg.present?
        @camps_registrations = @camp_reg
      else
        @camps_registrations = CampsRegistration.new(user_id: current_user.id, camp_id: params[:id])
        @camps_registrations.save
      end
      session[:camp_reg_id] = @camps_registrations.id
    end
  end

  private

  def set_camp
    @camp = Camp.find(params[:id])
  end
end
