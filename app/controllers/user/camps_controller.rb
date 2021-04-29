class User::CampsController < User::UsersController
  before_action :set_camp, only: %i[show introduction]
  
  def index
    @camps = Camp.all
  end

  def show
    date = Date.now()
    redirect_to 
  end

  def introduction; end

  private

  def set_camp
    @camp = Camp.find(params[:id])
  end
end
