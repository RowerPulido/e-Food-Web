class Users < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :last_name
      t.string :cellphone
      t.timestamps
    end
  end
end
