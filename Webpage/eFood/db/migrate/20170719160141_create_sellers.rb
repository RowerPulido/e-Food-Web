class CreateSellers < ActiveRecord::Migration[5.0]
  def change
    create_table :sellers do |t|
      t.integer :user_id
      t.integer :id_branch_office
      t.string :RFC
      t.string :CLABE
      t.timestamps
    end
  end
end
