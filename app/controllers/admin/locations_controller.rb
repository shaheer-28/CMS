class Admin::LocationsController < Admin::AdminsController
  include Pagy::Backend
  
  before_action :location_params, only: %i[update create]
  before_action :set_location, only: %i[show edit update destroy]

  def index
    @pagy, @locations = pagy(Location.all)
  end

  def show; end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location: params.dig(:location, :location))
    if @location.save
      redirect_to admin_location_path(@location), notice: 'Location has been created'
    else
      render 'new', alert: @location.errors.full_messages.to_sentence
    end
  end

  def edit; end

  def update
    if @location.update(location: params.dig(:location, :location))
      redirect_to admin_locations_path, notice: 'Location has been updated'
    else
      render 'edit', notice: @location.errors.full_messages.to_sentence
    end
  end

  def destroy
    if @location.destroy
      flash[:notice] = 'Location has been deleted'
    else
      flash[:alert] = @location.errors.full_messages.to_sentence
    end
    redirect_to admin_locations_path
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end
  
  def location_params
    params.require(:location).permit(:location)
  end
end
