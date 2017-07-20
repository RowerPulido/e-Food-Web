class CreateDishes < ActiveRecord::Migration[5.0]
  def change
    create_table :dishes do |t|
      t.integer branch_offices_id
      t.string name
      t.timestamps
    end
  end
end
