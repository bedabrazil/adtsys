class CreateCarMarks < ActiveRecord::Migration
  def change
    create_table :car_marks do |t|
      t.string :name
      t.string :fipe_name
      t.string :fipe_key
      t.integer :fipe_id

      t.timestamps null: false
    end
  end
end
