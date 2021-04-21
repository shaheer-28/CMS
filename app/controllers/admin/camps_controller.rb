class Admin::CampsController < ApplicationController
  include Pagy::Backend
  include Orderable

  require 'csv'

  helper_method :sort_column, :sort_direction
  
  before_action :check_role
  before_action :camp_params, only: %i[update create]
  before_action :set_camp, only: %i[show edit update destroy]

  def index
    @all_camps = Camp.all
    @pagy, @camps = pagy(Camp.search(params[:search_key]), items: Camp::CAMPS_PER_PAGE)

    if sort_column(@camps).present? && sort_direction.present?
      @camps = @camps.order(sort_column(@camps) + ' ' + sort_direction)
    end

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
    @camp = Camp.new
  end

  def create
    @camp = Camp.new(location: params[:camp][:location])
    if @camp.save
      flash[:notice] = 'Camp has been created'
      redirect_to admin_camp_path(@camp)
    else
      flash[:alert] = 'Unable to create Camp'
      render 'new'
    end
  end

  def edit; end

  def update
    if @camp.update(location: params[:camp][:location])
      flash[:notice] = 'Camp has been updated'
      redirect_to admin_camps_path
    else
      flash[:alert] = 'Unable to update Camp'
      render 'edit'
    end
  end

  def destroy
    if @camp.destroy
      flash[:notice] = 'Camp has been deleted'
    else
      flash[:alert] = 'Unable to delete Camp'
    end
    redirect_to admin_camps_path
  end

  private

  def set_camp
    @camp = Camp.find(params[:id])
  end
  
  def check_role
    redirect_to users_path if current_user.user?
  end

  def camp_params
    params.require(:camp).permit(:location, :search_key)
  end
end