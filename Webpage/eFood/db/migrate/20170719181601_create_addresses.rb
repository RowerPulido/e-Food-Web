class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.integer :client_id
      t.string :street
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country
      t.timestamps
    end
  end
end
