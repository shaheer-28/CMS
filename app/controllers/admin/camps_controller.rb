class Admin::CampsController < Admin::AdminsController
  before_action :camp_params, only: %i[update create]
  before_action :set_camp, only: %i[show edit update destroy]

  def index
    @camps = Camp.all
  end

  def show; end

  def new
    @camp = Camp.new
  end

  def create
    @camp = Camp.new(camp_params)
    
    if @camp.save 
      redirect_to admin_camps_path, notice: 'Camp has been created'
    else
      render 'new', notice: @camp.errors.full_messages.to_sentence
    end
  end

  # def edit; end

  # def update
  #   if @camp.update(location: params.dig(:camp, :location))
  #     redirect_to admin_camps_path, notice: 'Camp has been updated'
  #   else
  #     render 'edit', notice: @camp.errors.full_messages.to_sentence
  #   end
  # end

  def status_update
    p camp_params.inspect
  end

  def destroy
    if @camp.destroy
      flash[:notice] = 'Camp has been deleted'
    else
      flash[:alert] = @camp.errors.full_messages.to_sentence
    end
    redirect_to admin_camps_path
  end

  private

  def set_camp
    @camp = Camp.find(params[:id])
  end
  
  def camp_params
    params.require(:camp).permit(:name, :start_date, :end_date, :status, location_ids: [])
  end
end
