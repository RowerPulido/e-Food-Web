class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :user_id
      t.timestamps
    end
  end
end
