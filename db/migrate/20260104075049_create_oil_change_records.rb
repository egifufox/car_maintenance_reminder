class CreateOilChangeRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :oil_change_records do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.date :changed_at, null: false
      t.integer :mileage, null: false
      t.text :memo

      t.timestamps
    end
  end
end
