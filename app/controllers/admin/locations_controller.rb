class Admin::LocationsController < Admin::AdminsController
  include Pagy::Backend

  require 'csv'

  helper_method :sort_column, :sort_direction
  
  before_action :location_params, only: %i[update create]
  before_action :set_location, only: %i[show edit update destroy]

  def index
    @pagy, @locations = pagy(Location.search(params[:search_key]).order(sort_column + ' ' + sort_direction), items: Location::LOCATIONS_PER_PAGE)

    @all_locations = Location.all
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"locations-list\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def show; end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location: location_params)
    if @location.save
      redirect_to admin_location_path(@location), notice: 'Location has been created'
    else
      render 'new', alert: @location.errors.full_messages.to_sentence
    end
  end

  def edit; end

  def update
    if @location.update(location: location_params)
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
    params.dig(:location, :location)
  end

  def sort_column
    params[:sort] || "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
