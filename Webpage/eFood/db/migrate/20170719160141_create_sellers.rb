class CreateSellers < ActiveRecord::Migration[5.0]
  def change
    create_table :sellers do |t|
      t.integer :user_id
      t.integer :kitchen_id
      t.integer :brand_id
      t.string :RFC
      t.string :CLABE
      t.timestamps
    end
  end
end
