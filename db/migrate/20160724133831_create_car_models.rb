class CreateCarModels < ActiveRecord::Migration
  def change
    create_table :car_models do |t|
      t.string :name
      t.string :fipe_name
      t.string :fipe_key
      t.integer :fipe_id
      t.references :car_mark, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
