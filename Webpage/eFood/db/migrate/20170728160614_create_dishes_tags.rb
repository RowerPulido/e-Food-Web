class CreateDishesTags < ActiveRecord::Migration[5.0]
  def change
    create_table :dishes_tags do |t|
      t.integer :dish_id
      t.integer :tag_id
      t.timestamps
    end
  end
end
