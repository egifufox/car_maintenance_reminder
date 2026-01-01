class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :manufacturer, null: false, foreign_key: true
      t.string :vehicle_name, null: false
      t.string :model, null: false
      t.integer :year, null: false
      t.integer :vehicle_type, default: 0, null: false
      t.integer :current_mileage, default: 0, null: false

      t.timestamps
    end
  end
end
