class CreateVehiclePrices < ActiveRecord::Migration
  def change
    create_table :vehicle_prices do |t|
      t.string :name
      t.string :mark
      t.string :year_model
      t.string :price
      t.string :fuel
      t.string :reference
      t.references :car_model_year, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
