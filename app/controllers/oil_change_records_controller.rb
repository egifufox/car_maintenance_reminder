class OilChangeRecordsController < ApplicationController
  before_action :set_vehicle

  def index
    @oil_change_records = @vehicle.oil_change_records.order(changed_at: :desc)
  end

  def new
    @oil_change_record = @vehicle.oil_change_records.build
  end

  def create
    @oil_change_record = @vehicle.oil_change_records.build(oil_change_record_params)

    if @oil_change_record.save
      redirect_to vehicle_path(@vehicle), success: t('oil_change_records.create.success')
    else
      flash.now[:danger] = t('oil_change_records.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_vehicle
    @vehicle = current_user.vehicles.find(params[:vehicle_id])
  end

  def oil_change_record_params
    params.require(:oil_change_record).permit(:changed_at, :mileage, :memo)
  end
end
