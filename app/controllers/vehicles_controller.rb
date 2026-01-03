class VehiclesController < ApplicationController
  before_action :authenticate_user!

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
    @vehicle = current_user.vehicles.find(params[:id])
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:manufacturer_id, :vehicle_name, :model, :year, :vehicle_type, :current_mileage)
  end
end
