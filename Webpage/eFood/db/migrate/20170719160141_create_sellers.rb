class CreateSellers < ActiveRecord::Migration[5.0]
  def change
    create_table :sellers do |t|
      t.string :user_id
      t.string :id_office
      t.string :RFC
      t.string :CLAVE
      t.timestamps
    end
  end
end
