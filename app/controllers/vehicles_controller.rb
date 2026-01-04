class VehiclesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vehicle, only: [:show, :edit, :update, :destroy]


  def index
    @vehicles = current_user.vehicles.all
  end

  def new
    @vehicle = Vehicle.new
    @manufacturers = Manufacturer.all
  end

  def create
    @vehicle = current_user.vehicles.build(vehicle_params)

    if @vehicle.save
      redirect_to vehicle_path(@vehicle), success: t('vehicles.create.success', item: Vehicle.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_created', item: Vehicle.model_name.human)
      @manufacturers = Manufacturer.all
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    @manufacturers = Manufacturer.all
  end

  def update
    if @vehicle.update(vehicle_params)
      redirect_to vehicle_path(@vehicle), success: t('defaults.flash_message.updated', item: Vehicle.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_updated', item: Vehicle.model_name.human)
      @manufacturers = Manufacturer.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @vehicle.destroy!
    redirect_to vehicles_path, success: t('defaults.flash_message.deleted', item: Vehicle.model_name.human), status: :see_other
  end

  private
  
  def set_vehicle
    @vehicle = current_user.vehicles.find(params[:id])
  end

  def vehicle_params
    params.require(:vehicle).permit(:manufacturer_id, :vehicle_name, :model, :year, :vehicle_type, :current_mileage)
  end
end
