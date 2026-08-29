class ChangeNullConstraintOnVehiclesModelAndYear < ActiveRecord::Migration[7.0]
  def change
    change_column_null :vehicles, :model, true
    change_column_null :vehicles, :year, true
  end
end
