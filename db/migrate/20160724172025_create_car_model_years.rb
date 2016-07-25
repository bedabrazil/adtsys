class CreateCarModelYears < ActiveRecord::Migration
  def change
    create_table :car_model_years do |t|
      t.string :name
      t.string :fipe_key
      t.references :car_model, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
