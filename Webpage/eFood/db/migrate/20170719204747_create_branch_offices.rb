class CreateBranchOffices < ActiveRecord::Migration[5.0]
  def change
    create_table :branch_offices do |t|
      t.integer admin_id
      t.integer brand_id
      t.string name
      t.string address
      t.string zone
      t.timestamps
    end
  end
end
