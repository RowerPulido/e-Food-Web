class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.integer :client_id
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country
      t.string :card_number
      t.string :security_code
      t.string :expiry_date
      t.timestamps
    end
  end
end
