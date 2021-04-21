class Admin::CampsController < ApplicationController
  include Pagy::Backend
  
  before_action :check_role
  before_action :camp_params, only: %i[update create]
  before_action :get_camp, only: %i[show edit update destroy]

  def index
    #@camps = Camp.all
    @pagy, @camps = pagy(Camp.all)
  end

  def show; end

  def new
    @camp = Camp.new
  end

  def create
    @camp = Camp.new(location: params[:camp][:location])
    p "CAMP = #{@camp.inspect}"
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

  def get_camp
    @camp = Camp.find(params[:id])
  end
  
  def check_role
    redirect_to users_path if current_user.user?
  end

  def camp_params
    params.require(:camp).permit(:location)
  end
end
