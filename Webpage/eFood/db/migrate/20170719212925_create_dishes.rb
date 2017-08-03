class CreateDishes < ActiveRecord::Migration[5.0]
  def change
    create_table :dishes do |t|
      t.integer :kitchen_id
      t.integer :preparation_time
      t.integer :price
      t.string :name
      t.timestamps
    end
  end
end
