class OilChangeRecordsController < ApplicationController
  before_action :set_vehicle
  before_action :set_oil_change_record, only: [:edit, :update, :destroy]

  def index
    @oil_change_records = @vehicle.oil_change_records.order(changed_at: :desc)
  end

  def new
    @oil_change_record = @vehicle.oil_change_records.build
  end

  def create
    @oil_change_record = @vehicle.oil_change_records.build(oil_change_record_params)

    if @oil_change_record.save
      redirect_to vehicle_oil_change_records_path(@vehicle), success: t('oil_change_records.create.success')
    else
      flash.now[:danger] = t('oil_change_records.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @oil_change_record.update(oil_change_record_params)
      redirect_to vehicle_oil_change_records_path(@vehicle), success: t('defaults.flash_message.updated', item: OilChangeRecord.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_updated', item: OilChangeRecord.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @oil_change_record.destroy!
    redirect_to vehicle_oil_change_records_path(@vehicle), success: t('defaults.flash_message.deleted', item: OilChangeRecord.model_name.human), status: :see_other
  end

  private

  def set_vehicle
    @vehicle = current_user.vehicles.find(params[:vehicle_id])
  end

  def set_oil_change_record
    @oil_change_record = @vehicle.oil_change_records.find(params[:id])
  end

  def oil_change_record_params
    params.require(:oil_change_record).permit(:changed_at, :mileage, :memo)
  end
end
