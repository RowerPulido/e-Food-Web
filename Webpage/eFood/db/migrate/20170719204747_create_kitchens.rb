class CreateKitchens < ActiveRecord::Migration[5.0]
  def change
    create_table :kitchens do |t|
      t.integer :seller_id
      t.integer :brand_id
      t.string :name
      t.string :address
      t.string :zone
      t.timestamps
    end
  end
end
